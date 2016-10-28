class OrderItemsController < ApplicationController
  before_action :get_order_item, only: [:update, :destroy, :show, :ship]
  skip_before_action :require_login

  def index
    @order = Order.find(session[:order_id])
    @order_items = @order.order_items
  end

  def show
    @payment_detail = @order_item.order.payment_detail
  end

  def update
    product = @order_item.product
    if product.update_quantity(order_item_params["quantity"])
      @order_item.update(order_item_params)
    else
      flash[:error] = "Could not increase item quantity"
    end
    redirect_to order_order_items_path(@order_item.order)
  end

  def ship
  # mark order_item as shipped
  # check the order that the product belongs to to see if it can be marked as completed (called in complete order method)
    @order_item.shipped = true
    @order_item.save

    order = @order_item.order
    order.complete_order

    redirect_to order_order_items_path(@order_item.order)
  end


  def destroy
    order = @order_item.order
    @order_item.destroy
    redirect_to order_order_items_path(order)
  end

  private
    def get_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:quantity, :shipped)
    end
end
