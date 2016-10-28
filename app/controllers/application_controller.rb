class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_cart_id
  before_action :view

  private

  def set_cart_id
    if session[:cart_id].nil?
      new_order = Order.create(status: "pending")
      session[:cart_id] = new_order.id
    end
  end

  def view
      @product = Product.all
    if session[:user_id]
      @session = false
    else @session = true
    end
  end
end
