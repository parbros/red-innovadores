module Refinery
  module Experiences
    class Experience < Refinery::Core::BaseModel
      self.table_name = 'refinery_experiences'

      default_scope order('created_at DESC')

      attr_accessible :title, :content, :user_id, :position, :pdf_files_attributes

      acts_as_indexed :fields => [:title, :content]
      acts_as_commentable

      validates :content, :presence => true, :uniqueness => true
      
      has_many :pdf_files, as: :fileable
      belongs_to :user
      
      accepts_nested_attributes_for :pdf_files
      
      after_create :add_points
      
      def self.recent(count)
        order('created_at DESC').limit(count)
      end
      
      def add_points
        user.change_points({points: 15, type:  Type.where(name: "Innovador").first.id})
      end
    end
  end
end
