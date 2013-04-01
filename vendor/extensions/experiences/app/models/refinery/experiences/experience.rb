module Refinery
  module Experiences
    class Experience < Refinery::Core::BaseModel
      self.table_name = 'refinery_experiences'

      attr_accessible :title, :content, :user_id, :position

      acts_as_indexed :fields => [:title, :content]

      validates :content, :presence => true, :uniqueness => true
      
      belongs_to :user
      has_many :comments
      
      def self.recent(count)
        order('created_at DESC').limit(count)
      end
    end
  end
end
