class Level < ActiveRecord::Base
  belongs_to :badge  
  belongs_to :user, class_name: 'Refinery::User'
  attr_accessible :badge_id, :user_id
end
