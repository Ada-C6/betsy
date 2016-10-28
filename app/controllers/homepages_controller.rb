class HomepagesController < ApplicationController

  def index
    @product_categories = Product.uniq.pluck(:category)
    # grabbing all listings
    @products = Product.all
  end

  def show_category
    # @product = Product.find(params[:id])
    @product_category = params[:category]
    @products_in_category = Product.where(:category => @product_category)
  end

end
