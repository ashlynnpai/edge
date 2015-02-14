class AddColumnsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :institution, :string
    add_column :courses, :instructor, :string
    add_column :courses, :price, :string
    add_column :courses, :description, :text
    add_column :courses, :url, :string
    add_column :courses, :language, :string
  end
end
