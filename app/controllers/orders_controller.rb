class OrdersController < ApplicationController
  before_action :total, :shopping_cart
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @order_item = OrderItem.new
      @cart.each do |item|
        @order_item.product_id = item.values[0]
        @order_item.quantity = item.values[1]
        @order_item.order_id = @order.id
        @order_item.save
      end
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
    @orders = Order.all
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
    params.require(:order).permit(:date_purchased, :email, :cc_name, :cc_number, :cc_exp_year, :cc_exp_month, :billing_zip, :address, :total, )
  end
end
