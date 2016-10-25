class CartsController < ApplicationController
  before_action :shopping_cart
  def index

    @cart.each do | k, v|
      @id = k
    end
    @order_item = OrderItem.find_by(product_id: @id)
    raise

    if @order_item != nil
      @product = Product.find(@id)

      # @product.order_items << @order_item
      # @product.save
      # @order_item.save
      #   return @cart
    else
      return @cart
    end
  end

  def add_to_cart
    id = params[:id]
    @product = Product.find(id)
    @order_item = OrderItem.create
    @product.order_items << @order_item
    @product.save
    @order_item.save
    if @cart[id]
      @cart[id] = @cart[id] + 1
    else
      @cart[id] = 1
    end
    redirect_to carts_path
  end

  def sub_cart
    cart = session[:cart]
    cart[params[:id]] = cart[params[:id]] - 1
    redirect_to carts_path
  end

  def destroy

   @order_item = OrderItem.find_by(product_id: params[:id])
   @order_item.destroy
    # @cart = shopping_cart
    # @product = @cart.product.find(params[:id]).destroy
    redirect_to carts_path
  end

  def empty_cart
    session[:cart] = nil
    redirect_to carts_path
  end
end
