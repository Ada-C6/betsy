class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update]
  # before_action :find_merchant, only: [:new, :create, :edit, :update]

  def index
    @products = Product.all
  end

  def show
    @reviews = @product.reviews.order('stars desc, id').limit(3)
  end

  def new
    @product = Product.new
    @post_path = products_path
    @post_method = :post
  end

  def create
    @product = Product.new(product_params)
    # @product.merchant_id = @merchant.id
    @product.rating = 0

    if @product.save
      redirect_to product_path
    else
      @error = "Did not save successfully. Please try again."
      @post_path = products_path
      @post_method = :post
      render :new
    end
  end

  def edit
    @post_path = product_path
    @post_method = :put
  end

  def update
    if @product.update(product_params)
      redirect_to product_path
    else
      @error = "Did not save successfully. Please try again."
      @post_path = product_path
      @post_method = :put
      render :edit
    end
  end

  def destroy
    @product = find_product
    if @product.class == Product
      @product.destroy
      redirect_to products_path
    end
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
