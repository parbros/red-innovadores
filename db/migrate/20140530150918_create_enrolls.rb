class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.integer :course_id
      t.integer :user_id
      t.boolean :enrolled

      t.timestamps
    end
  end
end
