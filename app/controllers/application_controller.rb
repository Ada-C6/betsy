class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    helper_method :current_order, :shopping_cart

    def current_order
        if !session[:order_id].nil?
            Order.find(session[:order_id])
        else
            Order.new
        end
    end
    def shopping_cart
      if session[:cart]
        @cart = session[:cart]
      else
        @cart ={}
      end
    end
end
