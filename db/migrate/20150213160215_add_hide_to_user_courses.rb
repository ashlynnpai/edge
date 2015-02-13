class AddHideToUserCourses < ActiveRecord::Migration
  def change
    add_column :user_courses, :hide, :boolean
  end
end
