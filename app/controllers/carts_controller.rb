class CartsController < ApplicationController
  before_action :shopping_cart

  def index
    @cart.each do | cart_item|
      @id = cart_item.keys.map {|k| k}
      @id = @id.join.to_i

    end
    # @order_item = OrderItem.find_by(product_id: @id)



    if @id != nil
      @product = Product.find(@id)
      @order_item = OrderItem.find_by(product_id: @id)


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
    begin
      @order_item = OrderItem.find(params[:product_id])
    rescue ActiveRecord::RecordNotFound
      nil
    end
    if @order_item.nil?

      @order_item = OrderItem.create
      @product.order_items << @order_item
        @product.save
        @cart.push({ @product.id => @order_item.quantity })
      @order_item.save
    end
    redirect_to carts_path
  end

  def sub_cart
    cart = session[:cart]
    cart[params[:id]] = cart[params[:id]] - 1
    redirect_to carts_path
  end

  def destroy
   @order_item = OrderItem.find_by(params[:product_id])


    # @cart = shopping_cart
    # @product = @cart.product.find(params[:id]).destroy
    redirect_to carts_path
  end

  def empty_cart
    session[:cart] = nil
    redirect_to carts_path
  end
end
