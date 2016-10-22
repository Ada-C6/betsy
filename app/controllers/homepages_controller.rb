class HomepagesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @products = Product.all
  end
end
