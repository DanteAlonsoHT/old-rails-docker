class Product < ActiveRecord::Base
  include AuditableService
  attr_accessible :name, :description, :price, :created_by_id, :updated_by_id

  belongs_to :creator, class_name: 'Administrator', foreign_key: :created_by_id
  belongs_to :updater, class_name: 'Administrator', foreign_key: :updated_by_id

  belongs_to :created_by, class_name: 'Administrator'
  belongs_to :updated_by, class_name: 'Administrator'

  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :product_images
  has_many :purchases

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 5000 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :created_by_id, :updated_by_id, presence: true
end
