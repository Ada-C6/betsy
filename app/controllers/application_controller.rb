class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_all

  private
  def set_all
    @user= User.find_by(id: session[:user_id])
    @users = User.all #these are all merchants
    @categories = Category.all
    @products = Product.all
  end
end
