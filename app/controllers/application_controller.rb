class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order, :shopping_cart


  private
  def current_user
    begin
      @current_user ||= Merchant.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      nil
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to login_path
    end
  end

  # def current_order
  #   if !session[:order_id].nil?
  #     Order.find(session[:order_id])
  #   else
  #     Order.new
  #   end
  # end

  def shopping_cart
    if !session[:cart].nil?
      @cart = session[:cart]
    else
      session[:cart]= {}
     @cart = session[:cart]
    end
  end

end
