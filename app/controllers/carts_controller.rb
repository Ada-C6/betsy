class CartsController < ApplicationController
  def index
    if session[:cart]
      @cart = session[:cart]
    else
      @cart ={}
    end
  end

  def add_to_cart
    id = params[:id]

    if session[:cart]
      cart = session[:cart]
    else
      session[:cart] = {}
      cart = session[:cart]
    end

    if cart[id]
      cart[id] = cart[id] - 1
    else
      cart[id] = 1
    end
    redirect_to carts_path
  end

  def sub_cart
    cart = session[:cart]
    cart[params[:id]] = cart[params[:id]] - 1
    redirect_to carts_path
  end

  def destroy
    cart = session[:cart]
    cart.destroy
    redirect_to carts_path
  end

  def empty_cart
    session[:cart] = nil
    redirect_to carts_path
  end
end
