class Refinery::Blog::Related < ActiveRecord::Base
  attr_accessible :post_id, :related_id

  belongs_to :post
  belongs_to :related_post, class_name: 'Refinery::Blog::Post'
end
