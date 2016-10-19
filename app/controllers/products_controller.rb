class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update]
  before_action :find_merchant, only: [:new, :create, :edit, :update]

  def index
    @products = Product.all
  end

  def show
    @reviews = @products.reviews
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.merchant_id = @merchant.id
    @product.save
  end

  def edit
  end

  def update
    if @product.update(student_params)
      redirect_to product_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :inventory, :rating)
  end

end
