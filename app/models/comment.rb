class Comment < ActiveRecord::Base
  self.table_name = 'comments'
  
  include Mailchimp
  
  include Humanizer
  require_human_on :create
  
  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  validates :body, :presence => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_votable

  belongs_to :commentable, :polymorphic => true

  # NOTE: Comments belong to a user
  belongs_to :user, class_name: 'Refinery::User'
  
  attr_accessible :body, :title, :subject, :email, :name, :parent_id, :user_id, :spam, :commentable, :email_other, :humanizer_answer, :humanizer_question_id
  
  after_create :suscribe_comment, :add_points
  
  validate :validate_is_spam
  
  attr_accessor :email_other

  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  
  class << self
    def unmoderated
      where(:state => nil)
    end

    def approved
      where(:state => 'approved')
    end

    def rejected
      where(:state => 'rejected')
    end
  end

  self.per_page = Refinery::Blog.comments_per_page
  
  def self.build_from(obj, user_id, comment)
    new \
      :commentable => obj,
      :body        => comment,
      :user_id     => user_id
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  def validate_is_spam
    errors.add(:email_other, "spam!!!!") if email_other.present?
  end
  
  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end
  
  def name
    user.present? ? self.user.full_name : attributes['name']
  end
  
  def email
    user.present? ? self.user.email : attributes['email']
  end
  
  def approve!
    self.update_attribute(:state, 'approved')
  end

  def reject!
    self.update_attribute(:state, 'rejected')
  end

  def rejected?
    self.state == 'rejected'
  end

  def approved?
    self.state == 'approved'
  end

  def unmoderated?
    self.state.nil?
  end
  
  def ham?
    true
  end

  def self.toggle!
    currently = Refinery::Setting.find_or_set(:comments_allowed, true, {
      :scoping => 'blog'
    })
    Refinery::Setting.set(:comments_allowed, {:value => !currently, :scoping => 'blog'})
  end

  before_create do |comment|
    unless Moderation.enabled?
      comment.state = comment.ham? ? 'approved' : 'rejected'
    end
  end
  
  def add_points
    user.change_points({points: 10, type:  Type.where(name: "Comentador").first.id}) if user
    user.change_points({points: 5, type:  Type.where(name: "Innovador").first.id}) if user && commentable_type == 'Refinery::Experiences::Experience' || commentable_type == 'Refinery::Ideas:Idea'
  end

  module Moderation
    class << self
      def enabled?
        Refinery::Setting.find_or_set(:comment_moderation, true, {
          :scoping => 'blog',
          :restricted => false
        })
      end

      def toggle!
        new_value = {
          :value => !Blog::Comment::Moderation.enabled?,
          :scoping => 'blog',
          :restricted => false
        }
        Refinery::Setting.set(:comment_moderation, new_value)
      end
    end
  end

  module Notification
    class << self
      def recipients
        Refinery::Setting.find_or_set(:comment_notification_recipients, (Refinery::Role[:refinery].users.first.email rescue ''),
        {
          :scoping => 'blog',
          :restricted => false
        })
      end

      def recipients=(emails)
        new_value = {
          :value => emails,
          :scoping => 'blog',
          :restricted => false
        }
        Refinery::Setting.set(:comment_notification_recipients, new_value)
      end

      def subject
        Refinery::Setting.find_or_set(:comment_notification_subject, "New inquiry from your website", {
          :scoping => 'blog',
          :restricted => false
        })
      end

      def subject=(subject_line)
        new_value = {
          :value => subject_line,
          :scoping => 'blog',
          :restricted => false
        }
        Refinery::Setting.set(:comment_notification_subject, new_value)
      end
    end
  end
end
