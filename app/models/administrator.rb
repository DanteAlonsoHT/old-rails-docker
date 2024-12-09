class Administrator < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :password, :password_confirmation

  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :name, presence: true, length: { maximum: 100 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
end
