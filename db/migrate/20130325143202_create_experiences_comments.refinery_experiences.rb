# This migration comes from refinery_experiences (originally 2)
class CreateExperiencesComments < ActiveRecord::Migration

  def up
    create_table :refinery_experiences_comments do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.integer :user_id
      t.integer :experience_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-experiences"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/experiences/experiences"})
    end

    drop_table :refinery_experiences_comments

  end

end
