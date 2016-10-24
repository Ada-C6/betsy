class ProductsController < ApplicationController
  before_action :get_product, only: [:show, :edit, :update, :destroy]

  # Kelly: I don't know how to use controller filter here yet. So I will temporarily skip authentication requirements.

  skip_before_action :require_login, except: [:new, :create]

  # products_path	GET	/products
  # merchant_products_path	GET	/merchants/:merchant_id/products
  def index
    if params[:category_id] != nil
      category = Category.find(params[:category_id])
      @products = category.products
    elsif params[:merchant_id] != nil
      @merchant = Merchant.find(params[:merchant_id])
      @products = @merchant.products
    else
      @products = Product.all
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
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_product = @merchant.products.build
  end

  # edit_merchant_product_path	GET	/merchants/:merchant_id/products/:id/edit
  def edit; end

  # merchant_products_path POST	/merchants/:merchant_id/products
  def create
    merchant = Merchant.find(params[:merchant_id])
    @merchant_product = merchant.products.create(product_params)
    redirect_to merchant_path(merchant.id)
  #   if @product.save
  #      redirect_to @product
  #   else
  #      render :new
  #   end
  end

  # merchant_product_path PATCH/PUT /merchants/:merchant_id/products/:id
  def update
    if @product.update(product_params)
       redirect_to @product
    else
       render :edit
    end
  end

  # merchant_product_path DELETE	/merchants/:merchant_id/products/:id
  def destroy
    @product.destroy
    redirect_to products_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :quantity, :image)
    end
end
