module Refinery
  module Ideas
    class Idea < Refinery::Core::BaseModel
      self.table_name = 'refinery_ideas'
      
      belongs_to :user
      has_many :votes

      attr_accessible :title, :content, :user_id, :position

      acts_as_indexed :fields => [:title, :content]

      validates :title, :presence => true, :uniqueness => true
      
      def self.recent(count)
        order('created_at DESC').limit(count)
      end
    end
  end
end
