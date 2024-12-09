class Customer < ActiveRecord::Base
  attr_accessible :name, :email

  has_many :purchases

  validates :name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
