class Role < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :memberships
  has_many :users, :through => :memberships, :uniq => true

  validates :name, presence: true
  validates :description, presence: true
  validates_uniqueness_of  :name, case_sensitive: false

end
