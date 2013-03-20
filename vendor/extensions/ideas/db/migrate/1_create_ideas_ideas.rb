class CreateIdeasIdeas < ActiveRecord::Migration

  def up
    create_table :refinery_ideas do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-ideas"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/ideas/ideas"})
    end

    drop_table :refinery_ideas

  end

end
