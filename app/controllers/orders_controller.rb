class OrdersController < ApplicationController

  before_action :require_merchant, only: [:index, :show]
  has_scope :status

  def index
    @status_orders = apply_scopes(Order).all
    merchant = Merchant.find_by(id: session[:user_id].to_i)
    @orders = merchant.orders(@status_orders)
    @paid = merchant.order_by_status("paid")
    @complete = merchant.order_by_status("complete")
    @pending = merchant.order_by_status("pending")
    @cancelled = merchant.order_by_status("cancelled")
  end

  def show
    @order = Order.find(params[:id])
    @orderitems = @order.find_merchant_order_items(session[:user_id])
  end

  def destroy
    begin
      @order = Order.find(session[:order])
      @order.destroy_items
      @order.destroy
      session[:order] = nil
      redirect_to carts_index_path
    rescue ActiveRecord::RecordNotFound
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def complete
    @order = Order.find(params[:id])
    @order.status = "complete"
    @order.save

    redirect_to orders_index_path
  end

  def cancel
    @order = Order.find(params[:id])
    @order.status = "cancelled"
    @order.save
    @order.update_cancel_stock

    redirect_to orders_show_path
  end

end
