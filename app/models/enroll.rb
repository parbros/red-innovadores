class Enroll < ActiveRecord::Base
  attr_accessible :course_id, :enrolled, :user_id

  belongs_to :user, class_name: 'Refinery::User'
  belongs_to :course

  after_create :send_enroll_notificaction

  after_update :send_subscription_notificacion

  def self.by_course_id(course_id)
    where(course_id: course_id)
  end

  def send_enroll_notificaction
    RedInnovacionMailer.enroll_notificaction(self).deliver!
  end

  def send_subscription_notificacion
    RedInnovacionMailer.subscription_notificaction(self).deliver! if enrolled_changed? and enrolled
  end
end
