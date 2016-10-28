class PagesController < ApplicationController

  # required for the test to be able to see the categories and products
  # is this good practice? is there a better way to get access to these in the tests?
  attr_reader :categories, :products

  def index
    @user = User.find_by(id: session[:user_id])
    @categories = Category.all
    @products = Product.all
  end

  def cart
    @user = User.find_by(id: session[:user_id])
    @order = Order.find_by user_id: @user.id, order_status: 'cart'
  end

end
