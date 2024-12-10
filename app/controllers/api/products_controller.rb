class Api::ProductsController < ApplicationController
  before_filter :authenticate_admin!

  swagger_controller :products, 'Product Management'

  swagger_config = {
    controller: 'products',
    description: 'Product Management',
    resource_path: '/products'
  }

  swagger_api :most_purchased_by_category do
    summary 'Get the most purchased products by category'
    notes 'Returns a list of products grouped by category, ordered by the number of purchases'
    response :ok, 'Successful response'
    response :unauthorized, 'Unauthorized access'
    param :header, 'Authorization', :string, :required, 'JWT authentication token'
  end

  def most_purchased_by_category
    data = Rails.cache.fetch('most_purchased_by_category', expires_in: 1.hour) do
      Category.includes(:products).map do |category|
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
    end
    render json: data
  end

  swagger_api :top_earning_by_category do
    summary 'Get the top-earning products by category'
    notes 'Returns a list of products grouped by category, ordered by total revenue ($)'
    response :ok, 'Successful response'
    response :unauthorized, 'Unauthorized access'
    param :header, 'Authorization', :string, :required, 'JWT authentication token'
  end

  def top_earning_by_category
    data = Rails.cache.fetch('top_earning_by_category', expires_in: 1.hour) do
      Category.includes(:products).map do |category|
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
    end
    render json: data
  end
end
