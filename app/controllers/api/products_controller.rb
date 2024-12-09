class Api::ProductsController < ApplicationController
  before_filter :authenticate_admin!
  
  def most_purchased_by_category
    data = Category.includes(:products).map do |category|
      {
        category: category.name,
        products: category.products
                          .select('products.id, products.name, COUNT(purchases.id) AS purchase_count')
                          .joins('LEFT OUTER JOIN purchases ON purchases.product_id = products.id')
                          .group('products.id')
                          .order('purchase_count DESC')
                          .limit(10)
                          .map { |product| { name: product.name, purchase_count: product.purchase_count.to_i } }
      }
    end
    render json: data
  end

  def top_earning_by_category
    data = Category.includes(:products).map do |category|
      {
        category: category.name,
        top_products: category.products
                              .select('products.id, products.name, SUM(purchases.price_at_sale) AS total_revenue')
                              .joins(:purchases)
                              .group('products.id, products.name')
                              .order('total_revenue DESC')
                              .limit(3)
                              .map { |product| { name: product.name, total_revenue: product.total_revenue.to_f } }
      }
    end
    render json: data
  end
end
