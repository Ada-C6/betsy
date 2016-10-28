class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order



  def current_order

      if !session[:order_id].nil?
        begin
          Order.find(session[:order_id])
        rescue StandardError => err
          render "/errors/not_found", status: :not_found
        end
      else
        Order.new
      end
  end

  private

  def current_user
    @current_user ||= Merchant.find_by(id: session[:merchant_id])
  end

  helper_method :current_user ## What is this?

end
