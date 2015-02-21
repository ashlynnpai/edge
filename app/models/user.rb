class User < ActiveRecord::Base  
  include Sluggable
  
  has_many :user_courses
  has_many :courses, through: :user_courses
  has_many :courseitems, -> { order(position: :asc, updated_at: :desc) }
  has_many :reviews
  has_many :posts
  has_many :replies
  
  sluggable_column :name
  
  has_secure_password validations: false
  
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 7}
  validates :name, presence: true,  uniqueness: { case_sensitive: false }
  validates_presence_of :password_confirmation, :if => :password_present?
  validates_confirmation_of :password, :if => :password_present?
  
  def password_present?
    !password.nil?
  end
  
end