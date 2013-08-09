module Refinery
  module Ideas
    class Vote < Refinery::Core::BaseModel
      self.table_name = 'refinery_ideas_votes'
      
      scope :votes_up, where(:tendency => 1)
      scope :votes_down, where(:tendency => -1)

      attr_accessible :tendency, :idea_id, :user_id
      belongs_to :user

      acts_as_indexed :fields => [:idea_id]
      
      after_create :add_points
      
      def add_points
        user.change_points({points: 5, type:  Type.where(name: "Innovador").first.id})
      end
    end
  end
end
