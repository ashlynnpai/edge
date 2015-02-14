class Category < ActiveRecord::Base
  include Sluggable


  
  sluggable_column :name
  
  
end