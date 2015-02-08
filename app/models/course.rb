class Course < ActiveRecord::Base
  include Sluggable
  
  has_many :user_courses
  has_many :users, through: :user_courses
  
  
  validates :name, presence: true, uniqueness: true
  validates :provider, presence: true

  sluggable_column :name
  
end