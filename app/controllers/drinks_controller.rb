class DrinksController < ApplicationController
  def index
    @products =  Product.all.shuffle
  end

  def show
    #IDEA: route templates related to user/products/order_items; etc
  end


end
