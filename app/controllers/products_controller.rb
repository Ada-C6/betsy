class ProductsController < ApplicationController
  before_action :current_order
  # before_action :check_user, only: [:edit, :update, :retired]

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

    # If user is not logged in OR user is not the owner of the product, show them the add review/add to cart button. If they are the owner, show them the edit link.
    if @current_user == nil || @current_user.id != @product.merchant_id
      @user_page = false
    else
      @user_page = true
    end
  end

  def new
    # This should only be visible to logged in users.
    # Within the context of a merchant, a form to create a new product.
    # If you're not logged in (e.g. @current_user = nil, display a login prompt)
    current_user
    # TODO: Need to add in checking if @current_user is nil (not logged in)
    if @current_user == nil
      redirect_to login_failure_path
    else
      @merchant = @current_user
      @product = @merchant.products.new
    end
    @all_categories = Category.all
  end

  def create
    current_user
    # Within the context of a merchant, post the form from new.
    @all_categories = Category.all

    if @current_user == nil
      redirect_to login_failure_path
    else
      @merchant = Merchant.find(@current_user.id)

      @product = @merchant.products.new(product_params)

      if @product.save(product_params)
        redirect_to new_product_product_category_path(@product.id)
        return
      else
        render :new
      end
    end
  end

  def edit
    current_user
    check_user
    @product = Product.find(params[:id])

  end


  def update
    current_user
    # This is the PATCH call when a merchant updates their product
    @product = Product.find(params[:id])

    @merchant = Merchant.find(@product.merchant_id)

    # if @merchant != @current_user
    #   # display some message and re-route to @current_user's page?
    # elsif @current_user == nil
    #   # redirect to login page.
    # end

    if @product.update(product_params)
      redirect_to merchant_path(@merchant.id)
    else
      render :edit
    end

  end

  def retired
    # TODO: This is the PATCH call when a merchant retires a product
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :stock_quantity, :description, :photo_url)
  end
  private

  def check_user
    if @current_user == nil
      flash[:notice] = "You need to log in to edit this."
      redirect_to product_path(Product.find(params[:id]))
    elsif !@current_user.products.include? Product.find(params[:id])
      flash[:notice] = "You cannot edit this product; it doesn't belong to you."
      redirect_to product_path(Product.find(params[:id]))
    end
  end
end
