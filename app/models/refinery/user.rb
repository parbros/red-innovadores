require 'devise'
require 'friendly_id'
require 'bcrypt'

module Refinery
  class User < Refinery::Core::BaseModel
    extend FriendlyId
    
    include Mailchimp

    has_and_belongs_to_many :roles, :join_table => :refinery_roles_users

    has_many :plugins, :class_name => "UserPlugin", :order => "position ASC", :dependent => :destroy
    has_many :authentications
    has_one :twitter_authentication, class_name: '::Authentication', conditions: ["authentications.provider = ?",'twitter']
    has_one :facebook_authentication, class_name: '::Authentication', conditions: ["authentications.provider = ?",'facebook']
    friendly_id :username
    has_many :levels
    has_many :badges, through: :levels
    has_many :points

    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable, :lockable and :timeoutable
    
    devise :cas_authenticatable, :recoverable
    
    mount_uploader :avatar, AvatarUploader

    # Setup accessible (or protected) attributes for your model
    # :login is a virtual attribute for authenticating by either username or email
    # This is in addition to a real persisted field like 'username'
    attr_accessor :login, :password, :password_confirmation

    attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :plugins, :login, :registration_completed, :first_name, :last_name,
                    :country_code, :age_range, :gender, :suscribed, :membership_level, :first_name, :last_name, :title, :organization,
                    :street_address, :city, :province, :postal_code, :phone, :fax, :website,
                    :enabled, :add_to_member_until, :role_ids, :suscribed, :country_code, 
                    :age_range, :gender

    validates :username, :presence => true, :uniqueness => true
    validates :email, :presence => true, :uniqueness => true
    before_validation :downcase_username
    before_create :complete_registration
    
    before_create :suscribe_to_mailchimp

    class << self
      # Find user by email or username.
      # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
      def find_for_database_authentication(conditions)
        value = conditions[authentication_keys.first]
        where(["username = :value OR email = :value", { :value => value }]).first
      end

    end
    
    def display_name
      full_name || username || email
    end
    
    def display_avatar
      avatar.present? ? avatar : '/assets/avatar.png'
    end
    
    def full_name
      "#{first_name} #{last_name}" if first_name.present? and last_name.present?
    end

    def plugins=(plugin_names)
      if persisted? # don't add plugins when the user_id is nil.
        UserPlugin.delete_all(:user_id => id)

        plugin_names.each_with_index do |plugin_name, index|
          plugins.create(:name => plugin_name, :position => index) if plugin_name.is_a?(String)
        end
      end
    end

    def authorized_plugins
      plugins.collect(&:name) | ::Refinery::Plugins.always_allowed.names
    end

    def can_delete?(user_to_delete = self)
      user_to_delete.persisted? &&
        !user_to_delete.has_role?(:superuser) &&
        ::Refinery::Role[:refinery].users.any? &&
        id != user_to_delete.id
    end

    def password=(new_password)
      @password = new_password
      self.encrypted_password = password_digest(@password) if @password.present?
    end

    def password_digest(password)
      ::BCrypt::Password.create("#{password}", :cost => 10).to_s
    end

    def can_edit?(user_to_edit = self)
      user_to_edit.persisted? && (
        user_to_edit == self ||
        self.has_role?(:superuser)
      )
    end

    def add_role(title)
      raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(::Refinery::Role)
      roles << ::Refinery::Role[title] unless has_role?(title)
    end

    def has_role?(title)
      raise ArgumentException, "Role should be the title of the role not a role object." if title.is_a?(::Refinery::Role)
      roles.any?{|r| r.title == title.to_s.camelize}
    end

    def create_first
      if valid?
        # first we need to save user
        save
        # add refinery role
        add_role(:refinery)
        # add superuser role if there are no other users
        add_role(:superuser) if ::Refinery::Role[:refinery].users.count == 1
        # add plugins
        self.plugins = Refinery::Plugins.registered.in_menu.names
      end

      # return true/false based on validations
      valid?
    end

    def to_s
      username.to_s
    end

    def to_param
      to_s.parameterize
    end
    
    def forem_admin?
      has_role?(:superuser) || has_role?(:administrador)
    end
    
    def apply_omniauth(omniauth)
      case omniauth['provider']
      when 'facebook'
        self.apply_facebook(omniauth)
      when 'twitter'
        self.apply_twitter(omniauth)
      end
      authentications.build(hash_from_omniauth(omniauth))
      save!
    end
    
    def change_points(options)
      if Gioco::Core::TYPES
        type_id = options[:type]
        points  = options[:points]
      else
        points  = options
      end
      type      = (type_id) ? Type.find(type_id) : false

      if Gioco::Core::TYPES
        raise "Missing Type Identifier argument" if !type_id
        old_pontuation  = self.points.where(:type_id => type_id).sum(:value)
      else
        old_pontuation  = self.points.to_i
      end
      new_pontuation    = old_pontuation + points
      Gioco::Core.sync_resource_by_points(self, new_pontuation, type)
    end

    def next_badge?(type_id = false)
      type              = (type_id) ? Type.find(type_id) : false
      if Gioco::Core::TYPES
        raise "Missing Type Identifier argument" if !type_id
        old_pontuation  = self.points.where(:type_id => type_id).sum(:value)
      else
        old_pontuation  = self.points.to_i
      end
      next_badge       = Badge.where("points > #{old_pontuation}").order("points ASC").first
      last_badge_point = self.badges.last.try('points')
      last_badge_point ||= 0

      if next_badge
        percentage      = (old_pontuation - last_badge_point)*100/(next_badge.points - last_badge_point)
        points          = next_badge.points - old_pontuation
        next_badge_info = { 
                            :badge      => next_badge,
                            :points     => points,
                            :percentage => percentage
                          }
      end
    end
    
    def social_points
      points.where(type_id: Type.where(name: "Social").first.id).sum(:value)
    end
    
    def comment_points
      points.where(type_id: Type.where(name: "Comentador").first.id).sum(:value)
    end
    
    def innovation_points
      points.where(type_id: Type.where(name: "Innovador").first.id).sum(:value)
    end
    
    def self.generate_rankings
     ranking = []
     
     if Gioco::Core::POINTS && Gioco::Core::TYPES
       Type.find(:all).each do |t|
         data = self
                 .select("#{self.table_name}.*, 
                          points.type_id, SUM(points.value) AS type_points")
                 .where("points.type_id = #{t.id}")
                 .joins(:points)
                 .group("type_id, refinery_users.id")
                 .order("type_points DESC")

         ranking << { :type => t, :ranking => data }
       
       end

     elsif Gioco::Core::POINTS && !Gioco::Core::TYPES
       ranking = self.order("points DESC")

     elsif !Gioco::Core::POINTS && !Gioco::Core::TYPES
       ranking = self
                   .select("#{self.table_name}.*,
                            COUNT(levels.badge_id) AS number_of_levels")
                   .joins(:levels)
                   .group("refinery_users.id")
                   .order("number_of_levels DESC")

     end

     ranking
   end

protected

    def apply_facebook(omniauth)
      if omniauth['extra']['raw_info'].present?
        self.email = omniauth['extra']['raw_info']['email'] if omniauth['extra']['raw_info']['email'].present? && email.blank?
        self.first_name = omniauth['extra']['raw_info']['first_name'] if omniauth['extra']['raw_info']['first_name'].present? && first_name.blank?
        self.last_name = omniauth['extra']['raw_info']['last_name'] if omniauth['extra']['raw_info']['last_name'].present? && last_name.blank?
      end
    end

    def apply_twitter(omniauth)
      if omniauth['extra']['raw_info'].present?
        self.email = omniauth['extra']['raw_info']['email'] if omniauth['extra']['raw_info']['email'].present? && email.blank?
        if omniauth['extra']['raw_info']['name'].present?
          name = extract_name(omniauth['extra']['raw_info']['name'])
          self.first_name = name[0] if first_name.blank?
          self.last_name = name[1] if last_name.blank?
        end
      end
    end

    def hash_from_omniauth(omniauth)
      {
        :provider => omniauth['provider'],
        :uid => omniauth['uid'],
        :token => (omniauth['credentials']['token'] rescue nil),
        :secret => (omniauth['credentials']['secret'] rescue nil)
      }
    end

    private
    # To ensure uniqueness without case sensitivity we first downcase the username.
    # We do this here and not in SQL is that it will otherwise bypass indexes using LOWER:
    # SELECT 1 FROM "refinery_users" WHERE LOWER("refinery_users"."username") = LOWER('UsErNAME') LIMIT 1
    def downcase_username
      self.username = self.username.downcase if self.username?
    end
    
    def extract_name(name)
      name_splited = name.split(' ')
      case name_splited.size
      when 2
        return [name_splited[0], name_splited[1]]
      when 3
        return [name_splited[0] , "#{name_splited[1]} #{name_splited[2]}"]
      when 4
        return ["#{name_splited[0]} #{name_splited[1]}", "#{name_splited[2]} #{name_splited[3]}"]
      end
    end
    
    def complete_registration
      self.registration_completed = true
    end
    
    def suscribe_to_mailchimp
      self.suscribe if self.suscribed?
    end
  end
end
