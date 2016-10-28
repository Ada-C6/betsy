class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :purchase]
  before_action :cart, only: [:show, :edit, :update, :purchase]
  skip_before_action :require_login, only: [:show, :edit, :update, :purchase]

  def show; end #this is the cart

  def merchant_view #merchant_orders_path
    if session[:merchant_id]
      @current_merchant = session[:merchant_id]
      @order = Order.find(params[:id])
      @order_items = @order.order_items
      @order_products = []
      @order_items.each do |item|
        @order_products << item.find_product
      end

      if @order_products.any? { |product| product.merchant_id == @current_merchant}
        render :merchant_view
      else
        render :view_error
      end
    else
      render :view_error
    end
  end

  def edit; end

  def update
    if @cart == nil # if the item does not exist
      redirect_to :index, flash: {notice: "That item does not exist."}
    end

    @cart.name = order_params(params)[:name]
    @cart.email = order_params(params)[:email]
    @cart.address = order_params(params)[:address]
    @cart.cc_number = order_params(params)[:cc_number][-4..-1] #saves last four digits only
    @cart.expiration_date = order_params(params)[:expiration_date]
    @cart.zip_code = order_params(params)[:zip_code]
    if @cart.save
      redirect_to confirmation_path
    else
      render :edit
    end
  end

  def purchase #sends you to the confirmation page
    set_order
    @items = @cart.order_items
    @total = @cart.total

    @cart.mark_as_paid

    @items.each do |item|
      product = item.find_product
      product.product_purchased(item.quantity)
    end

    render :purchase # REVIEW: does this need to be here since I am clearing the session data after this?

    session.delete(:order_id)
  end

  def ship
    @order = Order.find(session[:ship_order_id])
    if @order.mark_as_shipped
      redirect_to merchant_path(session[:merchant_id])
    else
      render :not_shipped
    end
  end

  private
    def set_order
      @cart = Order.find(session[:order_id])
    end

    def order_params(params)
      params.require(:order).permit(:name, :email, :address, :cc_number, :expiration_date, :cvv, :zip_code)
    end
end
