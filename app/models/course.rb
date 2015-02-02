class Course < ActiveRecord::Base
  
  include Sluggable
  
  validates :name, presence: true, uniqueness: true
  validates :provider, presence: true

  sluggable_column :name
  
end