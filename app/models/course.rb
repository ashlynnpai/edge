class Course < ActiveRecord::Base
  include Sluggable
  
  has_many :users_courses
  has_many :users, through :users_courses
  
  
  validates :name, presence: true, uniqueness: true
  validates :provider, presence: true

  sluggable_column :name
  
end