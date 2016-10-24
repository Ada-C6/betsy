class OrdersController < ApplicationController

  def create
    @params = params
    @order = Order.new(order_params(params))
    if @order.save
      redirect_to orders_path
    # else
    #   # @todo need to add @product_id = id in products#add controller
    #   render product_path(@product_id)
    end
  end
  # def show
  #   @order = Order.find(params[:id].to_i)
  # end
  #
  # def edit
  #   @order = Order.find(params[:id].to_i)
  #   # needs to be able to select the order_item
  # end
  private
  def order_params(params)
    params.require(:order).permit(:name, :email, :mailing_address, :cc_last_4, :cc_expire, :status)
  end
end
