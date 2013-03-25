class CreateExperiencesExperiences < ActiveRecord::Migration

  def up
    create_table :refinery_experiences do |t|
      t.string :title
      t.text :content
      t.integer :user_id
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

    drop_table :refinery_experiences

  end

end
