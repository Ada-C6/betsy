clas OrderitemsController < ApplicationController
  before_action :is_product_in_cart, only: [:create]
  # def index
  #   @order_items = OrderItem.all
  # end
  #
  # def new
  #   @order_item = OrderItem.new
  # end

  # def add_to_cart
  #   @item = OrderItem.new
  #   @item.quantity = 1
  #   @item.product_id = @product.id
  #   @product.inventory -= 1
  #   @item.save
  #
  #   redirect_to :index
  # end

  # Unsure where the redirect should go?
  def create
    @order = current_order
    @order_item = @order.order_items.create(order_item_params)
    session[:order_id] = @order.id
    redirect_to orderitems_path
  end

  # Unsure where redirect should go?
  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update_attributes(order_item_params)
    redirect_to orderitems_path
  end

  # Unsure where redirect should go?
  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    redirect_to orderitems_path
  end

  def current_order
    if session[:order_id]
      Order.find(session[:order_id])
    else
      Order.create
    end
  end

  def is_product_in_cart
    order = current_order
    @product_id = params[:order_item][:product_id]
    product_in_cart = order.order_items.select { |order_item| order_item.product_id == @product_id.to_i}

    if !product_in_cart.nil?
      update_cart(product_in_cart[0])
    end
  end

  def update_cart(product_in_cart)
    current_quantity = product_in_cart.quantity
    additional_quantity = params[:order_item][:quantity].to_i
    params[:order_item][:quantity] = current_quantity + additional_quantity

    product_in_cart.update_attributes(order_item_params)

    redirect_to orderitems_path
  end

  private

  # Do we want to add order_id, since it's associated with order?
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id, :merchant_id)
  end
end
