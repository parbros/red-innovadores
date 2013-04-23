module Refinery
  module Experiences
    class Comment < Refinery::Core::BaseModel
      self.table_name = 'refinery_experiences_comments'

      attr_accessible :name, :email, :comment, :user_id, :experience_id, :position

      acts_as_indexed :fields => [:user_id]

      validates :comment, :presence => true, :uniqueness => true
      
      belongs_to :user
      belongs_to :experience
    end
  end
end
