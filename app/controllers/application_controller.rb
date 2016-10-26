class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this allow us to block guests from certain pages:
  helper_method :current_user


  # if @current_user is not set then Merchant.find_by(id) will set the current_user
  def current_user
    @current_user ||= Merchant.find_by(id: session[:user_id]) if session[:user_id]
  end

  def require_merchant
    redirect_to categories_index_path unless current_user
  end

end
