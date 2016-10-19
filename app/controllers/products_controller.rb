class ProductsController < ApplicationController

  def index
    @product = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
  private

  def product_params
    params.require(:product).permit(:name, :description, :stock, :price,:photo_url, :merchant_id)
  end

end
