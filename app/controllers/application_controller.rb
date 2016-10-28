class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login
  helper_method :category, :merchant, :current_merchant

  def current_merchant
      @current_merchant ||= Merchant.find(session[:merchant_id]) if session[:merchant_id]
  end

  def require_login
    if current_merchant.nil?
      flash[:error] = "You have been logged out. Please continue to browse our website as a Guest User."
      redirect_to root_path
    end
  end

  def category
    Category.all
  end

  def merchant
    Merchant.all
  end
end
