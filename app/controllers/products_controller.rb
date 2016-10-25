class ProductsController < ApplicationController
  def index
    @products = Product.all.order("name")
  end

  def show
    @product = Product.find(params[:id].to_i)

    if @product.user_id
      @seller = @product.user
      # @seller = User.find(@product.user_id)
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
    @product = Product.new
  end

  def create
    @product = Product.new(name: params[:product][:name], description: params[:product][:description], price: params[:product][:price], inventory: params[:product][:inventory], category: params[:product][:category], user_id: session[:user_id])
    @product.save

    redirect_to show_seller_products_path(@product.id)
    # does rails think I mean to redirect to the method instead of the path? why doesn't it need an id for this route?
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
