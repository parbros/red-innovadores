class CreateCoversCovers < ActiveRecord::Migration

  def up
    create_table :refinery_covers do |t|
      t.integer :image_id
      t.text :caption
      t.integer :post_id
      t.integer :idea_id
      t.integer :experience_id
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-covers"})
    end

    drop_table :refinery_covers

  end

end
