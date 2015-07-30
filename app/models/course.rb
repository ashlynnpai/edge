class Course < ActiveRecord::Base
  include Sluggable
  
  has_many :user_courses
  has_many :users, through: :user_courses
  
  has_many :course_categories
  has_many :categories, through: :course_categories
  
  has_many :reviews
  has_many :posts
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :institution, presence: true
  has_many :queue_items

  sluggable_column :name
  
  def self.show_latest_courses(num)
    Course.order('created_at DESC').first(num)  
  end
  
end