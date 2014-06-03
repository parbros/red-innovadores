class Enroll < ActiveRecord::Base
  attr_accessible :course_id, :enrolled, :user_id

  belongs_to :user, class_name: 'Refinery::User'

  def self.by_course_id(course_id)
    where(course_id: course_id)
  end
end
