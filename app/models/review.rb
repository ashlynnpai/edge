class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :course, touch: true
  
  validates :content, presence: true
end