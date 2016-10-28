class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update]

  before_action :require_login, only: [:new, :create, :edit, :create]

  # products_path	GET	/products
  # merchant_products_path	GET	/merchants/:merchant_id/products
  def index
    if params[:category_id] != nil
      category = Category.find(params[:category_id])
      @products = category.products.where(active: true)
    elsif params[:merchant_id] != nil
      @merchant = Merchant.find(params[:merchant_id])
      @products = @merchant.products.where(active: true)
    else
      @products = Product.where(active: true)
    end
  end

  # product_path	GET	/products/:id
  # merchant_product_path	GET	/merchants/:merchant_id/products/:id
  def show
    session[:product_id] = @product.id
    @review = Review.new
    @reviews = Review.where product_id: @product.id
  end

  # new_merchant_product_path	GET	/merchants/:merchant_id/products/new
  def new
    @product = @current_merchant.products.new
  end

  # merchant_products_path POST	/merchants/:merchant_id/products
  def create
    @product = @current_merchant.products.new(product_params)
    if @product.save
      redirect_to products_path
    else
      #TODO Put flash notice here maybe.
      render :new, status: 400
    end
  end

  # edit_merchant_product_path	GET	/merchants/:merchant_id/products/:id/edit
  def edit
    if @product.merchant_id != session[:merchant_id]
      render :no_show, status: 400
    end
  end

  # merchant_product_path PATCH/PUT /merchants/:merchant_id/products/:id
  def update
    if @product.merchant_id != session[:merchant_id]
      render :no_show, status: 400
    end

    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit, status: 400
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :quantity, :image, :description, :active, category_ids: [])
    end
end
