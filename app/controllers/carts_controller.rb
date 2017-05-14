class CartsController < ApplicationController
  before_action :find_product, only: [:create, :edit]

  def create
      if session[:cart_id] == nil
        @cart = Cart.create
        session[:cart_id] = @cart.id
      end

      product_found = false
      @cart = CartProduct.where(cart_id: session[:cart_id])
      @cart.each do |i|
        if i.product_id == @product.id && i.product_quantity < @product.quantity
          i.product_quantity += 1
          i.save
          product_found = true
        elsif i.product_quantity == @product.quantity
          product_found = true
          flash[:notice] = "There are only #{@product.quantity} item(s) in stock!"
        end
      end

      if !product_found
        @cart_product = CartProduct.new
        @cart_product.product_quantity = 1
        @cart_product.product_id = @product.id
        @cart_product.cart_id = session[:cart_id]
        @cart_product.save
      end

    redirect_to(:back)
  end

  def edit


    redirect_to(:back)
  end

  def update
  end

  def show
    @products = Product.all
    @cartproducts = CartProduct.all
    @cart = CartProduct.where(cart_id: session[:cart_id])

  end

  def destroy
    @cart_product = CartProduct.find(params[:id].to_i)
    @cart_product.destroy

    redirect_to(:back)
  end

  def empty
    @cart = CartProduct.where(cart_id: session[:cart_id])
    if @cart.length != 0
      @cart.each do |i|
        i.destroy
      end
    else
      flash[:notice] = "You cannot empty and already empty cart!"
    end

    redirect_to(:back)
  end

  def increase
    @cart_product = CartProduct.find(params[:id].to_i)
    @product = Product.find(@cart_product.product_id)
    if @cart_product.product_quantity < @product.quantity
      @cart_product.product_quantity += 1
      @cart_product.save
    elsif @cart_product.product_quantity == @product.quantity
      flash[:notice] = "There are only #{@product.quantity} item(s) in stock!"
    end
    redirect_to(:back)
  end

  def decrease
    @cart_product = CartProduct.find(params[:id].to_i)
    if @cart_product.product_quantity > 1
      @cart_product.product_quantity -= 1
      @cart_product.save
    elsif @cart_product.product_quantity == 1
      @cart_product.destroy
    end
    redirect_to(:back)
  end

  private
  #this method is never used
  def user_params
    params.require(:cart_product).permit(:product_quantity, :product_id, :cart_id)
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end

  #this method is never used
  def product_params
    params.require(:product).permit(:name, :description, :unit_price, :photo_url, :quantity)
  end
end
