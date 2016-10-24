class ProductsController < ApplicationController
  def index
    @products = Product.all.order("name")
  end

  def show
    @product = Product.find(params[:id].to_i)

    if @product.user_id
      @seller = User.find(@product.user_id)
    else
      @seller = User.new
    end

    @reviews = Review.where(:product_id => @product.id)

  end

  def show_seller_products
    @product = Product.find(params[:id].to_i)
    @products = Product.where(:user_id => @product.user_id)
  end

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
