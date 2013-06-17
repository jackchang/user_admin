class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :role_names, :user_name, :role_ids
  has_many :memberships 
  has_many :roles, :through => :memberships, :uniq => true

  validates :user_name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_uniqueness_of :user_name, case_sensitive: false
  validates :user_name, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
