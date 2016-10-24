class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update]

  def index
    @products = Product.all
    if params[:search]
      @products = Product.search(params[:search]).order("created_at DESC")
    else
      @products = Product.all.order("created_at DESC")
    end
  end

  def show
    begin
      @product = Product.find(params[:id])
    rescue StandardError => err
      render "/errors/not_found", status: :not_found
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.price *= 100
    @product.merchant_id = session[:merchant_id]
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

  private

  def product_params
    params.require(:product).permit(:name, :price, :inventory, :description, :photo_url)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
