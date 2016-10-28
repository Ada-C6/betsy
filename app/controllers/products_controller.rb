class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update]
  before_action :find_merchant, except: [:all_products]

  def all_products
    @products = Product.all
  end

  def index
    @products = Product.where(merchant_id: @merchant.id)
  end

  def show
    puts "Products is NIL" if @product == nil
    @reviews = @product.reviews.order('stars desc, id').limit(3)
    @line_item = LineItem.new ### OR Line.new
  end

  def new
    @product = Product.new
    @post_path = merchant_products_path(@merchant.id)
    @post_method = :post
    @category = Category.order("lower(name) ASC").all
  end

  def create 
    @product = Product.new(product_params)
    @product.price = (product_params[:price].to_f * 100).to_i
    # @product.merchant_id = @merchant.id
    @product.rating = nil
    @product.merchant_id = @merchant.id
    if @product.save
      redirect_to merchant_product_path(@merchant.id, @product.id)
    else
      @error = "Did not save successfully. Please try again."
      @post_path = merchant_products_path
      @post_method = :post
      render :new
    end
  end

  def edit
    @post_path = merchant_product_path(@merchant.id, @product.id)
    @post_method = :put
  end

  def update
    if @product.update(product_params)
      @product.price = (product_params[:price].to_f * 100).to_i
      @product.rating
      redirect_to merchant_product_path(@merchant.id, @product.id)
    else
      @error = "Did not save successfully. Please try again."
      @post_path = merchant_product_path(@merchant.id, @product.id)
      @post_method = :put
      render :edit
    end
  end

  def destroy
    @product = find_product
    if @product.class == Product
      @product.destroy
      redirect_to merchant_products_path(@merchant.id)
    end
  end

  private

  def find_product
    if Product.exists?(params[:id].to_i) == true
      return @product = Product.find_by(id: params[:id].to_i)
    else
      render :status => 404
    end
  end

  def find_merchant
    if Merchant.exists?(params[:merchant_id].to_i) == true
      return @merchant = Merchant.find(params[:merchant_id].to_i)
    else
      render :status => 404
    end
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :image, :inventory, :rating, category_ids: [])
  end

end
