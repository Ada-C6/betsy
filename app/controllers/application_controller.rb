class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def current_user
    # Placeholder, this should be replaced with the actual session user, which should be added to the merchant's table if it's not there already.
    @current_user = Merchant.last
  end
end
