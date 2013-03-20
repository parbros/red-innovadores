class CreateIdeasVotes < ActiveRecord::Migration

  def up
    create_table :refinery_ideas_votes do |t|
      t.integer :tendency
      t.integer :idea_id
      t.integer :user_id

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

    drop_table :refinery_ideas_votes

  end

end
