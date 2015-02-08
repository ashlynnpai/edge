class CreateUserCourses < ActiveRecord::Migration
  def change
    create_table :user_courses do |t|
      t.integer :user_id, :course_id
      t.string :status
      t.boolean :course_creator
      t.timestamps
    end
  end
end
