class Point < ActiveRecord::Base
  belongs_to :type  
  belongs_to :user, class_name: 'Refinery::User'
  attr_accessible :type_id, :user_id, :value
end
