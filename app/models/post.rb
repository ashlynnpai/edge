class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :course
  has_many :replies
  
  validates :title, presence: true
  validates :content, presence: true
end