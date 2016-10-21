class GuestsController < ApplicationController
  def index
    @products = Product.all
    @product_count = @products.length
  end

end
