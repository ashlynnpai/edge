class Category < ActiveRecord::Base
  include Sluggable
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }


  
  sluggable_column :name
  
  
end