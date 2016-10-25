class CartsController < ApplicationController
  before_action :shopping_cart
  def index
    # if !@cart.empty?
        @cart.each do | k, v|
        @id = k
      end
      @product = Product.find(@id)
      @order_item = OrderItem.new
      @product.order_items << @order_item
      @product.save
    #   return @cart
    # else


      return @cart
    # end
  end

  def add_to_cart
    id = params[:id]
    @product = Product.find(id)
    @order_item = OrderItem.new
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

  @product = Product.find(params[:id])
    session[:cart].delete(@product)
    # @cart = shopping_cart
    # @product = @cart.product.find(params[:id]).destroy
    redirect_to carts_path
  end

  def empty_cart
    session[:cart] = nil
    redirect_to carts_path
  end
end
