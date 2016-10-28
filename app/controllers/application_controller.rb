class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def current_user
    begin
      @current_user ||= Merchant.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      @current_user = nil
    end
  end

  def require_login
    if current_user.nil?
      flash[:error] = "Please log in to continue."
      redirect_to root_path
    end
  end

  # faking an order!
  def current_order
    begin
      @current_order_id = session[:order_id]
      #we can fake this by setting it to 6
      # @current_order_id = 6
    rescue ActiveRecord::RecordNotFound
      @current_order_id = nil
    end
  end
end
