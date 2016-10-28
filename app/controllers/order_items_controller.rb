class OrderItemsController < ApplicationController
  def create # this action gets the order_id from the url/params (because of nested routing)
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.new(order_item_params)

    @product = @order_item.product

    # if @order.order_items. @TODO - WIP - ks

    if @order_item.save
      redirect_to edit_order_path(@order)
    else
      render 'products/show'
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @product = @order_item.product

    @order_items = @order.order_items # required for rendering orders/edit page within this action

    if @order_item.update(order_item_params)
      redirect_to edit_order_path(@order)
    else
      render 'orders/edit'
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order

    @order_item.destroy

    redirect_to edit_order_path(@order)
  end

  def ship
    @order_item = OrderItem.find(params[:id])
    @order_item.shipped = true
    @order_item.save
    redirect_to order_path(params[:order_id])
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :quantity)
  end
end
