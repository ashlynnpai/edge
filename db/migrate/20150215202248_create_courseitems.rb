class CreateCourseitems < ActiveRecord::Migration
  def change
    create_table :courseitems do |t|
      t.integer :course_id, :user_id
      t.integer :position
      t.timestamps
    end
  end
end
