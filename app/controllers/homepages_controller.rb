class HomepagesController < ApplicationController

  def root
    @product_categories = Product.uniq.pluck(:category)
  end

  def show_category
    @product_category = params[:category]
    @products_in_category = Product.where(:category)
  end

end
