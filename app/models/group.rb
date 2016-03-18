class Group < ActiveRecord::Base
  has_many :users
  has_many :topics, :dependent => :destroy

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :category, presence: true, length: { maximum: 20 }

end
