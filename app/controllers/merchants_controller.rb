class MerchantsController < ApplicationController

  skip_before_action :require_login, only: [:index, :show]

  def index
    @merchants = Merchant.all
  end

  def show
    begin
      @merchant = Merchant.find(params[:id])
    rescue ActiveRecord::RecordNotFound => err
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
      return
    end

    @products = Product.where(merchant_id: @merchant.id)

    @merchant_oi_revenue = @merchant.find_all_order_items_revenue

    @merchant_oi_revenue_by_status = @merchant.find_all_order_items_revenue_by_status

    @merchant_oi_count_by_status = @merchant.find_total_number_of_orders_by_status

    @merchant_orders = @merchant.find_orders

    @merchant_order_items = @merchant.find_order_items_from_orders
  end
end
