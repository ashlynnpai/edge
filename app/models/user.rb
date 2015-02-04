class User < ActiveRecord::Base
  include Sluggable
  sluggable_column :name
  
  has_secure_password validations: false
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum: 7}
  validates :name, presence: true, uniqueness: true
  
end