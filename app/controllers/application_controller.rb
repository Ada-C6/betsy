class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # this allow us to block guests from certain pages:
  helper_method :current_user
  helper_method :active_products

  def active_products
    @products = []
    Product.all.each do |p|
      if p.retired == false
        @products << p
      end
    end
    return @products
  end


  # if @current_user is not set then Merchant.find_by(id) will set the current_user
  def current_user
    @current_user ||= Merchant.find_by(id: session[:user_id]) if session[:user_id]
  end
  private
  def require_merchant
     unless current_user
       flash[:notice] = "You must be logged in to access merchant section"
       redirect_to homepages_index_path
     end
  end

end
