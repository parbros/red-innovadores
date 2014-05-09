class CreateRefineryBlogRelateds < ActiveRecord::Migration
  def change
    create_table :refinery_blog_relateds do |t|
      t.integer :post_id
      t.integer :related_post_id

      t.timestamps
    end
  end
end
