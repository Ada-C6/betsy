class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  private

  def current_user
    @current_user ||= Merchant.find_by(id: session[:merchant_id])
  end

  helper_method :current_user ## What is this?

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to login_failure_path
    end
  end
end
