class ProductsController < ApplicationController
  before_action :set_product_or_merchant, only: [:show, :edit, :update, :destroy]
  before_action :set_merchant, only: [:new, :create]

  before_action :cart, only: [:add_to_cart]

  def index
    if params[:category_id]
      @products = Category.find(params[:category_id]).products
      render :index
    elsif params[:merchant_id]
      @products = Merchant.find(params[:merchant_id]).products
      render :index
    end
    @products = Product.all
  end

  def show
    @order_item = OrderItem.new(product_id: @product.id)
    @latest_review = Review.all.where(product_id: params[:id]).order(:updated_at).first
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.merchant_id = @merchant.id
    if @product.save
      redirect_to merchant_path(@merchant)
    else
      render :new
    end
  end

  def edit
    if !@merchant.nil?
      if session[:merchant_id] != @product.merchant_id
        render :edit_error
      end
    end
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  # def destroy
  #   @product.destroy
  #   redirect_to merchant_path(@merchant)
  # end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_or_merchant
      begin
        @product = Product.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])

      rescue
        nil
      end

    end

    def set_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :description, :photo_url, :stock, category_ids: [])
    end
end
