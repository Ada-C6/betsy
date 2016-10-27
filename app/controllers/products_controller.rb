class ProductsController < ApplicationController
  before_action :find_product, only: [:edit, :update, :reinstate_product, :retire_product]
  before_action :merchant_owns_product, only: [:edit]

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
    @order = current_order
    @order_item = @order.order_items.new

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
    @categories_array = Category.all.map { |category| [Category.find(category.id).name, category.id] }
    @prod_cat = CategoryProduct.new
  end

  def create
    @product = Product.new(product_params)
    @product.merchant_id = session[:merchant_id]
    if @product.save
      @product.price *= 100
      @product.save

      find_categories

      redirect_to product_path(@product)
    else
      @categories_array = Category.all.map { |category| [Category.find(category.id).name, category.id] }
      render :new
    end
  end

  def edit;
    @product.price /= 100.0
    @categories_array = Category.all.map { |category| [Category.find(category.id).name, category.id] }
  end

  def update
    @product.price *= 100
    if @product.update(product_params)
      @product.categories.each do |i|
        @product.categories.delete(Category.find(i.id))
      end

      find_categories

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

  def merchant_owns_product
    product = Product.find(params[:id])
    unless current_user && current_user.id == product.merchant_id
      redirect_to product_path(product)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :inventory, :description, :photo_url)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def find_categories
    categories = params[:category_ids]
    if categories
      categories.each do |c|
        @product.categories << Category.find(c)
      end
    end
  end
end
