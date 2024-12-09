class Category < ActiveRecord::Base
  attr_accessible :name, :created_by_id, :updated_by_id

  belongs_to :creator, class_name: 'Administrator', foreign_key: :created_by_id
  belongs_to :updater, class_name: 'Administrator', foreign_key: :updated_by_id
  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :created_by_id, :updated_by_id, presence: true
end
