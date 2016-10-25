class ProductsController < ApplicationController

    # Will likely need to remove this line (or further customize this), once we've narrowed down which pages require login. This line allows our tests to pass.
    skip_before_action :require_login, only: [:show, :index]


  before_action :find_product, only: [:show, :edit, :update]

  def index
    @products = Product.all
    @order_item = current_order.order_items.new
  end

  def show; end

# should be limited to merchants
  # def new
  # end
  #
  # def create
  # end
  #
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  # def destroy
  # end

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
