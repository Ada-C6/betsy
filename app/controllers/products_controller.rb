class ProductsController < ApplicationController

# products               products#index
# merchant_products      products#index
# "            "         products#create
# new_merchant_product   products#new
# edit_merchant_product  products#edit
# product                products#show
# merchant_product       products#show
# "             "        products#update
# "             "        products#update
# "             "        products#destroy

  def index
    @products = Product.all
    @order_item = current_order.order_items.new
  end

  def show
    @product = Product.find(params[:id])
  end

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

end
