class CartsController < ApplicationController
  before_action :shopping_cart

  def index
    @products = []
    @cart.each do |item|
      @products << Product.find(item["id"])
    end
  end

  def add_to_cart
    id = params[:id]
    @product = Product.find(id)
    if !@cart.empty?

      @cart.each do |k, v|
        if k["id"] = @product.id
          k["quantity"] = k["quantity"] + 1
        end
      end
    else
      @cart << {"id" => @product.id, "quantity" =>1}
    end
    session[:cart] = @cart

    # begin
    #   @order_item = OrderItem.find(params[:product_id])
    # rescue ActiveRecord::RecordNotFound
    #   nil
    # end
    # if @order_item.nil?
    #
    #   @order_item = OrderItem.create
    #   @product.order_items << @order_item
    #     @product.save
    #
    #   @order_item.save
    # end
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

  private

  def shopping_cart
    if !session[:cart].nil?
      @cart = session[:cart]
    else
      session[:cart] = []
      @cart = session[:cart]

    end
  end

end
