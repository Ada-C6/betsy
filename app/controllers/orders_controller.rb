class OrdersController < ApplicationController
  before_action :current_user, only: [:show]

  def cart
    # find Order object from session[:cart_id] & redirect to its edit page
    @order = Order.find(session[:cart_id])
    redirect_to edit_order_path(@order)
  end

  def show # for user's sold ordered items
    @order = Order.find(params[:id])
    @orders = @current_user.orders
    #keeps an unauthorized user to access orders that do not belong to them
    unless @orders.include?(@order)
      flash[:errors] = "Sorry, you're not a vendor for this order."
      redirect_to user_path(@current_user)
    end

    @matched_items = [] #collects all matching order items
    @current_user.order_items.each do |item|
      if item.order_id == @order.id
        @matched_items <<  item
      end
      return @matched_items
    end
  end

  def edit # for "cart"/pending order (the update actions for this happen in OrderItemsController)
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  def checkout # "edit"-like action for checkout/order confirmation when moving order to paid
    @order = Order.find(params[:id])
  end

  def update # update action for CHECKOUT - order moving to paid
    @order = Order.find(params[:id])

    # Update inventory for purchased products, update order status to "paid"
    @order.complete_checkout

    # Clear the current cart
    session[:cart_id] = nil

    if @order.update(order_params)
      redirect_to confirmation_path(@order)
    else
      render :checkout
    end
  end

  def confirmation # for paid order confirmation
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:placed, :email, :mailing_address, :mailing_city, :mailing_state, :mailing_zip, :cc_holder_name, :cc_number, :exp, :cvv, :billing_zip, :status)
  end

  #use this method to make sure signed in users cannot see other users' orders
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
