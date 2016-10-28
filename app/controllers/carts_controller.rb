class CartsController < ApplicationController
  before_action :shopping_cart
  before_action :product_ref, except: [:index, :empty_cart]
  after_action :no_item, only: [:less_prod, :delete_product]

  def index
    @products = {}
    @cart.each do |item|
      product = Product.find(item["id"])
      quantity = item["quantity"]
      if @total.nil?
        @total = 0
      end
      @total += quantity * product.price
      @products.merge!(product => quantity)
    end
    return @products
  end

  def add_to_cart
    if !@cart.empty?
      @cart.each do |k, v|
        unless k.values[0] == @product.id
          @cart << {"id" => @product.id, "quantity" =>1}
        end
      end
    else
      @cart << {"id" => @product.id, "quantity" =>1}
    end
    session[:cart] = @cart
    redirect_to carts_path
  end


  def more_prod
    @cart.each do |k, v|
      if k.values[0] == @product.id
        k["quantity"] = ( k["quantity"] + 1)
      end
    end
    redirect_to carts_path
  end

  def less_prod
    @cart.each do |k, v|
      if k.values[0] == @product.id
        k["quantity"] = ( k["quantity"] - 1)
      end
    end
    redirect_to carts_path
  end

  def delete_product
    @cart.each do |k, v|
      if k.values[0] == @product.id
        k["quantity"] =   0
      end
    end
    redirect_to carts_path
  end

  def empty_cart
    session[:cart] = nil
    redirect_to carts_path
  end

  private
  def no_item
    @cart.delete_if {|k| k["quantity"] == 0}
  end

  def total
  end

  def product_ref
    @product = Product.find(params[:id])
  end

end
