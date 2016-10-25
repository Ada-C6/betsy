class OrderitemsController < ApplicationController
  def index
    @order_items = OrderItem.all
  end

  def new
    @order_item = OrderItem.new
  end

  def add_to_cart
    @item = OrderItem.new
    # @product = Product.find(params[:id])
    # product = Product.find(@product.id)
    @item.quantity = 1
    @item.product_id = @product.id
    @product.inventory -= 1
    @item.save

    redirect_to orderitems_path
  end

  def create
    @order_item = OrderItem.new(order_params)
    if @order_item.save
      redirect_to orderitems_path
    else
      render :new
    end
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      redirect_to orderitems_path
    else
      render :edit
    end
  end

  def destroy
    OrderItem.find(params[:id]).destroy
    redirect_to orderitems_path
  end

  private

  def order_item_params
    params.require(:order).permit(:quanity, :product_id, :merchant_id)
  end
end
