class CreatePdfFiles < ActiveRecord::Migration
  def change
    create_table :pdf_files do |t|
      t.string :fileable_type
      t.integer :fileable_id
      t.string :file

      t.timestamps
    end
  end
end
