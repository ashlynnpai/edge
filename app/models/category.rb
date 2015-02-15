class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :course_categories
  has_many :courses, through: :course_categories

  sluggable_column :name
  
  
end