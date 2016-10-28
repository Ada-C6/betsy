class MerchantsController < ApplicationController
  before_action :current_order

  def index
    @merchants = Merchant.all
  end

  def show
    current_user
    @merchant = Merchant.find(params[:id])

    @cumulative_revenue = 0
    @merchant.products.each do |product|
      @total_revenue = 0
      @item = OrderItem.where(product_id: product.id)
      @price = product.price
      @item.each do |i|
        @revenue = i.quantity * @price
        @total_revenue += @revenue
      end
      @cumulative_revenue += @total_revenue
    end
    #
    # @revenue = {}
    # @order_items.each do |item|
    #   @prdct = Product.find(item.product_id)
    #   merchant = @prdct.merchant_id
    #   price = @prdct.price
    #   quantity = item.quantity
    #   @item_revenue = price * quantity
    #   @revenue[merchant] = @item_revenue
    # end

    if @current_user == nil || @current_user != @merchant
      @user_page = false
    else
      @user_page = true
    end

  end

end
