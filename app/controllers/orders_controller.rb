class OrdersController < ApplicationController
  before_action :current_order


  def create
    # if session[:order_id] != nil
    #   render :update
    #   return
    # else
      @product = Product.find_by(id: params[:product_id].to_i)
      @order = Order.new
      @order.status = "pending"
      if @order.save
        OrderItem.create_order_item(@product, @order)
        session[:order_id] = @order.id
        redirect_to product_path(@product) # might redirect to cart
      else
        flash[:notice] = "Sorry, something that wasn't supposed to happen, happened."
        redirect_to product_path(@product.id)
      end
    # end #session
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

  def update
    order_id = @current_order_id
    @order = Order.find(order_id)
    if @order.status == "pending"
      #SUCCESS
      @product = Product.find(params[:product_id])
      if OrderItem.update_order_item(@product, @order) != false
        @order.save ? flash[:notice] = "Your order is saved" : flash[:notice] = "Your order did not save"
      else
        flash[:notice] = "Sorry, this order is not valid"
        redirect_to products_path
        return
      end
      redirect_to order_path(@order)
    else #(not pending)
      flash[:notice] = "Sorry, this order is not valid"
      redirect_to products_path
    end #pending
  end

  def pay
    @order = Order.find(params[:id])
    if @order.update(order_params)
      # delete your order_id out of session so that you can make another order!
      @order.purchase_time = DateTime.now
      @order.save
      session.delete(:order_id)

      flash[:notice] = "Thank you for placing your order with BasketCase. Please come again soon!"
      redirect_to order_path(params[:id])
    else
      redirect_to root_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :mailing_address, :cc_last_4, :cc_expire, :status, )
  end
end
