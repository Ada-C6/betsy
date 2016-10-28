class OrdersController < ApplicationController
  before_action :shopping_cart
  before_action :find_order, except: [:index, :new, :create, :manage]

   def index
    @order = Order.find(session[:order_id]) if session[:order_id]
  end

  def show; end

  def new
    @order = Order.new
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

  def manage
    @products = Product.where(merchant_id: session[:user_id])
    @ordered_products = []
    @order_items = []
    @orders = []

    @products.each do |product|
      unless product.order_items.nil?
        @ordered_products << product
      end
    end

    @ordered_products.each do |product|
      order_items = OrderItem.where(product_id: product.id)
      order_items.each do |item|
        @order_items << item
      end
    end

    @order_items.each do |item|
      order = Order.find_by(id: item.order_id)
      @orders << order
    end
  end

  def destroy
    @order.destroy
    redirect_to portal_path
  end

  private

  def order_params
<<<<<<< HEAD
    params.require(:order).permit(:date_purchased, :email, :cc_name, :cc_number, :cc_exp_year, :cc_exp_month, :billing_zip, :address, :total )
=======
    params.require(:order).permit(:date_purchased, :email, :cc_name, :cc_number, :cc_exp_year, :cc_exp_month, :billing_zip, :address)
>>>>>>> manage-orders
  end

  def find_order
    begin
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

end
