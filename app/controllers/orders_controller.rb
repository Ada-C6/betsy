class OrdersController < ApplicationController
  before_action :current_order


  def create
    # if @product.stock_quantity > 0 else render product_path(@product.id)
    @product = Product.find_by(id: params[:product_id].to_i)
    #if @product == nil
    @order = @product.orders.new(order_params(params[:order]))
    @order.status = "pending"
    if @order.save
      # When a user creates a new order, we want to save it in their session until the pay for it, so that they can look at it (and check out!).
      session[:order_id] = @order.id
      redirect_to order_items_path
    else
      render product_path(@product.id)
    end
  end

  def show
    current_user
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)

    @revenue = {}
    @total_revenue = 0
    @order_items.each do |item|
      @prdct = Product.find(item.product_id)
      @price = @prdct.price
      @quantity = item.quantity
      @item_revenue = (@price * @quantity)
      @total_revenue = @item_revenue + @total_revenue
    end

  end


  def checkout
    # Edit order, is more like, edit the contact information of the user in the cart. This will be called when they go to checkout their order.
    @order = Order.find(params[:id])
  end

  def pay
    @order = Order.find(params[:id])
    if @order.update(order_params)
      # delete your order_id out of session so that you can make another order!
      session.delete(:order_id)

      flash[:notice] = "Thank you for placing your order with BasketCase. Please come again soon!"
      redirect_to order_path(params[:id])
    else
      redirect_to root_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :mailing_address, :cc_last_4, :cc_expire, :status)
    # params.permit!
  end
end
