class ProductsController < ApplicationController

  def index
    @product = Product.all
  end

  def show
    @product = Product.find()
  end

end
