class ProductImage < ActiveRecord::Base
  attr_accessible :product_id, :image_url

  belongs_to :product

  validates :product_id, presence: true
  validates :image_url, presence: true, format: { with: URI.regexp(%w(http https)) }
end
