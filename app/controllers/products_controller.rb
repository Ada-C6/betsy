class ProductsController < ApplicationController
  before_action :check_user, only: [:edit, :update, :retired]

  def index
    if params[:merchant_id] == nil
      #shows all the products in the site
      @products = Product.all
    elsif params[:merchant_id]
      # a view of products for a merchant
      merchant_id = params[:merchant_id]
      @merchant = Merchant.find(merchant_id)
      @products = Product.where(merchant_id: merchant_id)
    end
  end

  def show
    current_user
    # This is the individual product page
    @product = Product.find(params[:id])
    @categories = @product.categories
  end

  def new
    # This should only be visible to logged in users.
    # Within the context of a merchant, a form to create a new product.
    # If you're not logged in (e.g. @current_user = nil, display a login prompt)
    current_user
    @merchant = @current_user
    @product = @merchant.products.new
    # raise
  end

  def create
    current_user
    # Within the context of a merchant, post the form from new.
    @merchant = Merchant.find(params[:merchant_id])
    if @merchant != @current_user
      # display some message and re-route to @current_user's page?
    elsif @current_user == nil
      # redirect to login page.
    else
      @product = @merchant.products.new(product_params)
    end

    if @product.save(product_params)
      redirect_to merchant_path(@merchant)
    else
      render :edit
    end
  end

  def edit
    current_user
    # This is the page where a merchant can edit their own product, will have an authorization to make sure merchant's id matches product's merchant_id
    # TODO: should also have error messages if product is not valid.
  end


  def update
    # This is the PATCH call when a merchant updates their product
  end

  def retired
    # This is the PATCH call when a merchant retires a product
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :stock_quantity, :description, :photo_url)
  end
  private

  def check_user
    unless @current_user.products.include? Product.find(params[:id])
      render 'errors/wrong_user'
    end
  end
end
