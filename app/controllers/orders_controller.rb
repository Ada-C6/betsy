class OrdersController < ApplicationController
  before_action :shopping_cart
  def index
    @order = Order.find(session[:order_id]) if session[:order_id]
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    @order.total = 0
    if @order.save
      @cart.each do |item|
        @order_item = @order.order_items.new
        @order_item.product_id = item.values[0]
        @order_item.quantity = item.values[1]
        @order_item.save
      end
      @order.reload
      @order.update_total
      @order.save
      session[:order_id] = @order.id
      session[:cart] = nil
      redirect_to orders_path
    else
      render :new
    end
  end


  def update
    @order = Order.find(params[:id])
  end

  def manage_orders
    @order_items = OrderItems.all
    @product = Product.find_by(merchant_id: session[:user_id])
    @product.each do |prod|
      @order_item = OrderItem.find_by(product_id: prod.id)
    end
    @order
  end

  def destroy
  end

  private

  def order_params
    params.require(:order).permit(:date_purchased, :email, :cc_name, :cc_number, :cc_exp_year, :cc_exp_month, :billing_zip, :address, :total )
  end


end
