class ProductsController < ApplicationController
  def index
    @products = Product.all.order("name")
  end

  def show
    @product = Product.find(pramas[:id].to_i)
    @seller = User.find(@product.user_id)
    @reviews = Review.where(@product.id)
  end

  def show_products
    @product = Product.find(params[:id].to_i)

  end





  def by_seller_products
    @products = Product.where(:user_id)
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
