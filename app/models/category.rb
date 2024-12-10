class Category < ActiveRecord::Base
  include AuditableService
  attr_accessible :name, :created_by_id, :updated_by_id

  belongs_to :creator, class_name: 'Administrator', foreign_key: :created_by_id
  belongs_to :updater, class_name: 'Administrator', foreign_key: :updated_by_id

  belongs_to :created_by, class_name: 'Administrator'
  belongs_to :updated_by, class_name: 'Administrator'

  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :created_by_id, :updated_by_id, presence: true
end
