class OrdersController < ApplicationController
  def index
  end

  def new
  @order = Order.new
  end
  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @order_item = OrderItem.new
      @cart.each do |item|
        @order_item.product_id = item.values[0]
        @order_item.quantity = item.values[1]
        @order_item.order_id = @order.id
        @order_item.save
        redirect_to order_path
      end
    else
      render :new
    end
  end



  def update
      @order = Order.find(params[:id])
    if @order.update.save
    end
  end

  def destroy
  end
  private
  def order_params
  params.require(:order).permit(:date_purchased, :email, :cc_name, :cc_number, :cc_exp_year, :cc_exp_month, :billing_zip)
  end
end
