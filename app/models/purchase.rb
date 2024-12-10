class Purchase < ActiveRecord::Base
  attr_accessible :product_id, :customer_id, :price_at_sale, :purchased_at

  belongs_to :product
  belongs_to :customer

  validates :product_id, :customer_id, :price_at_sale, :purchased_at, presence: true
  validates :price_at_sale, numericality: { greater_than: 0 }

  after_create :send_first_purchase_email, if: :should_send_email?

  private

  def first_purchase?
    Purchase.where(product_id: product_id).lock(true).count == 1
  end

  def should_send_email?
    !Rails.env.test? && ENV['SKIP_EMAILS'].to_s != 'true' && first_purchase?
  end

  def send_first_purchase_email
    creator = product.creator
    other_admins = Administrator.where('id != ?', creator.id)
    PurchaseMailer.first_purchase_email(product, creator, other_admins).deliver
  end
end
