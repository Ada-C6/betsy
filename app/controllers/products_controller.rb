class ProductsController < ApplicationController
  before_action :find_product, except: [:index, :new, :manage, :create]
  before_action :require_login, except: [:index, :show]

  def index
    @products = Product.where(active:true)
  # @order_item = current_order.order_items.new
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.merchant_id = session[:user_id]
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def edit
    if @product.merchant_id == session[:user_id]
      render :edit
    else
      flash[:error] = "Please note: You are only allowed to edit your own products."
      redirect_to manage_products_path
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    unless @product.merchant_id == session[:user_id]
      flash[:error] = "Please note: You are only allowed to delete your own products."
      # redirect_to manage_products_path
    end
    @product.destroy
    redirect_to portal_path
  end

  def manage
    @products = Product.where(merchant_id: session[:user_id])
  end

  def retire
    if @product.active
      @product.active = false
    else
      @product.active = true
    end
    @product.save
    redirect_to portal_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :stock, :price,:photo_url, :merchant_id)
  end

  def find_product
    begin
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

end
