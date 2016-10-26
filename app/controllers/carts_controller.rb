class CartsController < ApplicationController
  def index
    begin
      if session[:order]
        @order = Order.find(session[:order])
      end
    rescue ActiveRecord::RecordNotFound
      session[:order] = nil
      flash[:notice] = "An error occurred and your cart could not be found. Your cart has been reset so you can continue shopping."
      redirect_to carts_index_path
    end
  end

  def show
  end

  def edit
    begin
      if session[:order]
        @order = Order.find(session[:order])
      else
        flash[:notice] = "Your cart is empty! Please add something to your cart before you check out."
        redirect_to carts_index_path
      end
    rescue ActiveRecord::RecordNotFound
      session[:order] = nil
      flash[:notice] = "An error occurred and your cart could not be found. Your cart has been reset so you can continue shopping."
      redirect_to carts_index_path
    end
  end

  def update
    begin
      if session[:order]
        @order = Order.find(session[:order])
        if @order.update(order_params, status: "paid", placed_at: DateTime.now)
          @order.update_stock
          session[:order] = nil
        else
          flash[:notice] = "An error occurred and your information could not be recorded. Please try again."
          redirect_to carts_index_path
        end
      else
        flash[:notice] = "Sorry, your cart could not be found. Please try again."
        redirect_to carts_index_path
      end
    rescue ActiveRecord::RecordNotFound
      session[:order] = nil
      flash[:notice] = "An error occurred and your cart could not be found. Your cart has been reset so you can continue shopping."
      redirect_to carts_index_path
    end
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def order_params

    filtered = params.require(:order).permit(:name, :address, :email, :city, :state, :zip, :card_name, :card_num, :cvv, :billing_zip, :expiry)
    base_date = DateTime.new(filtered['expiry(1i)'].to_i, filtered['expiry(2i)'].to_i)
    filtered.delete('expiry(3i)')
    filtered.delete('expiry(2i)')
    filtered.delete('expiry(1i)')
    filtered[:expiry] = base_date.end_of_month
    return filtered
  end

end
