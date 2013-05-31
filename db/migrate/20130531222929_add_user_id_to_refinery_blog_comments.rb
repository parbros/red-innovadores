class AddUserIdToRefineryBlogComments < ActiveRecord::Migration
  def change
    add_column :refinery_blog_comments, :user_id, :integer
  end
end
