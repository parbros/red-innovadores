class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :remote_courses_id
      t.boolean :enroll_available

      t.timestamps
    end
  end
end
