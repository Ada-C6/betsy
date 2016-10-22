class CartsController < ApplicationController
  def index
    if session[:order]
      @order = Order.find(session[:order])
    end
  end

  def show
  end

  def edit
    if session[:order]
      @order = Order.find(session[:order])
    else
      redirect_to carts_index_path
      flash[:notice] = "Your order has already been placed!"
    end
  end

  def update
    if session[:order]
      @order = Order.find(session[:order])
      @order.update(order_params)
      @order.update(status: "paid")
      @order.update(placed_at: DateTime.now)

      # Reduce the stock of each item when it is sold
      @order.orderitems.each do |orderitem|
        product = orderitem.product
        product.stock -= orderitem.quantity
        product.save
      end

      session[:order] = nil
    else
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
