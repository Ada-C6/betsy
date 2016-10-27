class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :reinstate_product, :retire_product]

  def index
    if params[:search]
      @products = Product.where(active: true).search(params[:search]).order("created_at DESC")
    else
      @products = Product.where(active: true).order("created_at DESC")
      if current_user
        @inactive_products = Product.where(merchant_id: current_user.id).where(active: false)
      end
    end
  end

  def show
    # raise
    begin
      product = Product.find(params[:id])
      if product.active == true || product.merchant_id == current_user.id
        @product = product
        @reviews = Review.where(product_id: @product.id)
        @average = Product.average(@reviews)
      else
        redirect_to products_path
      end
    rescue StandardError => err
      render "/errors/not_found", status: :not_found
    end
  end

  def new
    @product = Product.new
    # @product.active = true
  end

  def create
    @product = Product.new(product_params)
    @product.price *= 100
    @product.merchant_id = session[:merchant_id]
    # @product.active = true
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id]).destroy
    redirect_to products_path
  end

  def retire_product
    @product.active = false
    @product.save
    redirect_to products_path
  end

  def reinstate_product
    @product.active = true
    @product.save
    redirect_to product_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :inventory, :description, :photo_url)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
