class User < ActiveRecord::Base
  include Sluggable
  
  has_many :user_courses
  has_many :courses, through: :user_courses
  
  sluggable_column :name
  
  has_secure_password validations: false
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 7}
  validates :name, presence: true, uniqueness: true
  
end