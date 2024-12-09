class Api::PurchasesController < ApplicationController
  before_filter :authenticate_admin!

  def index
    from_date = params[:from].presence || Purchase.minimum(:purchased_at) || '1970-01-01'
    to_date = params[:to].presence || Time.now.end_of_day
  
    purchases = Purchase.includes(:product, :customer)
                        .where('purchased_at >= ?', from_date)
                        .where('purchased_at <= ?', to_date)
  
    if params[:admin_id].present?
      admin_ids = Array(params[:admin_id])
      purchases = purchases.where(products: { created_by_id: admin_ids })
    end
  
    if params[:category_id].present?
      category_ids = Array(params[:category_id])
      category_filter = ProductCategory.where(category_id: category_ids).select(:product_id)
      purchases = purchases.where(products: { id: category_filter })
    end
  
    if params[:customer_id].present?
      customer_ids = Array(params[:customer_id])
      purchases = purchases.where(customer_id: customer_ids)
    end
  
    render json: purchases.map { |purchase|
      {
        product: purchase.product.name,
        customer: purchase.customer.name,
        price: purchase.price_at_sale,
        purchased_at: purchase.purchased_at
      }
    }
  end

  def count_by_granularity
    granularity_mapping = {
      'hour' => "DATE_TRUNC('hour', purchased_at)",
      'day' => "DATE_TRUNC('day', purchased_at)",
      'week' => "DATE_TRUNC('week', purchased_at)",
      'year' => "DATE_TRUNC('year', purchased_at)"
    }
  
    granularity = granularity_mapping[params[:granularity]] || "DATE_TRUNC('day', purchased_at)"
  
    from_date = params[:from].presence || Purchase.minimum(:purchased_at) || '1970-01-01'
    to_date = params[:to].presence || Time.now.end_of_day
  
    purchases = Purchase.select("#{granularity} AS time_bucket, COUNT(*) AS purchase_count")
                        .where('purchased_at >= ?', from_date)
                        .where('purchased_at <= ?', to_date)
  
    if params[:admin_id].present?
      admin_ids = Array(params[:admin_id])
      purchases = purchases.joins(:product).where(products: { created_by_id: admin_ids })
    end
  
    if params[:category_id].present?
      category_ids = Array(params[:category_id])
      category_filter = ProductCategory.where(category_id: category_ids).select(:product_id)
      purchases = purchases.joins(:product).where(products: { id: category_filter })
    end
  
    if params[:customer_id].present?
      customer_ids = Array(params[:customer_id])
      purchases = purchases.where(customer_id: customer_ids)
    end
  
    purchases = purchases.group('time_bucket').order('time_bucket')
  
    render json: purchases.map { |purchase| { time: purchase.time_bucket, count: purchase.purchase_count } }
  end
end
