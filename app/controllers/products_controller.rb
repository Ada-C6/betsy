class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :find_merchant

  def new
    check_permissions("create")
    @product = Product.new
  end

  def create
    check_permissions("create")
    @product = Product.new(product_params)

    if @product.save
      redirect_to index_path
    else
      render :new
    end
  end

  def destroy
   check_permissions("delete")
    @product.destroy

    if @product.destroy
      redirect_to index_path
    end
  end

  def edit
    check_permissions("edit")
  end

  def update
    check_permissions("edit")
    @product.update(product_params)
    if @product.update(product_params)
     redirect_to product_path
    else
     render :edit
    end
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = @product.reviews
  end

  private
  def check_permissions(action)
    if @merchant == nil
      flash[:notice]= "you must be logged in as a merchant to #{action} products"
      return redirect_to index_path
    end
  end

  def find_merchant
    @merchant = User.find_by(id: session[:user_id])
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end

  def product_params
    params.require(:product).permit(:name, :description, :unit_price, :photo_url, :quantity).merge(user_id: session[:user_id])
  end

end
