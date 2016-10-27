class OrdersController < ApplicationController
    before_action :authenticate_user!, only: [:cancel_order]

  def add_to_cart
    # if there is no cart_id in session, or the cart_id can not be found in database, which means this user has no cart at all, we will create a new one.

    # two possibilities that @order can be nil: 1) session[:cart_id] == nil, 2) session[:cart_id] != nil && database does not have order with the :cart_id.
    if session[:cart_id]
      @order = Order.find_by(:id => session[:cart_id].to_i)
    end

    if !@order
      @order = Order.new
      @order.status = "pending"
      @order.user_id = session[:user_id]
      # save! ensure @order is saved, if not, it will raise an exception and visibly break the program.
      @order.save!
      session[:cart_id] = @order.id
    end

    @product = Product.find(params[:product_id])
    # if user puts more than one order_items with same product_id in cart in seperate occasions, there should be only one order_item for this product in cart.
    # Just update the total quantity of the order_items.

    # [TEST]write a test case here!

    order_items = OrderItem.where(:order_id => @order.id, :product_id => params[:product_id])

    if order_items.length >= 1
      @order_item = order_items.first
      @order_item.quantity += params[:quantity].to_i
      @order_item.save!
    else
      @order_item = OrderItem.new
      @order_item.order_id = session[:cart_id]
      @order_item.quantity = params[:quantity].to_i
      @order_item.unit_price = @product.price
      @order_item.product_id = @product.id
      @order_item.save!
    end
    redirect_to action: 'show_cart'
  end

  def show_cart
    if session[:cart_id]
      @order_items = OrderItem.where(:order_id => session[:cart_id])
    else
      @order_items = []
    end

    @order = Order.find_by(:id => session[:cart_id]) || Order.new
  end

  def change_quantity
    order_item_id = params[:order_item_id]
    order_item = OrderItem.find_by(:id => order_item_id)
    if !order_item
      redirect_to action: 'show_cart'
    end

    order_item.quantity = params[:quantity].to_i
    order_item.save!
    redirect_to action: 'show_cart'
  end

  def destroy_order_item
    order_item_id = params[:order_item_id]
    OrderItem.destroy(order_item_id)

    redirect_to action: 'show_cart'
  end

  def checkout
    if session[:cart_id]
      @order_items = OrderItem.where(:order_id => session[:cart_id])
    else
      @order_items = []
    end
    @order = Order.find_by(:id => session[:cart_id]) || Order.new

  end

  def create_order
    @order = Order.find(params[:order_id])

    @order.user_id = session[:user_id]
    @order.name = params[:order][:name]
    @order.email = params[:order][:email]
    @order.street_address = params[:order][:street_address]
    @order.city = params[:order][:city]
    @order.state = params[:order][:state]
    @order.zip = params[:order][:zip]
    @order.phone = params[:order][:phone]
    @order.cc_number = params[:order][:cc_number]
    @order.exp_month = params[:order][:exp_month]
    @order.exp_year = params[:order][:exp_year]
    @order.cvc = params[:order][:cvc]
    @order.save!

    # check if product inventory is sufficient for purchase quantity
    @order.order_items.each do |order_item|
      if order_item.quantity > order_item.product.inventory
        flash[:notice] = "#{order_item.product.name}'s inventory is not enough to fullfill your order. Please change your Quantity and submit again."
        redirect_to action: 'show'
      else
        @order.status = "paid"
        @order.save!
        session[:cart_id] = nil
      end
      # when sold, product's inventory is reduced accordingly.
      order_item.product.inventory -= order_item.quantity
      order_item.product.save!

      redirect_to confirmation_path(@order.id)
    end

  end

  def confirmation
    @order = Order.find(params[:order_id])
  end

  def cancel_order
    order_id = params[:order_id]
    order = Order.find(order_id)
    order.status = "cancelled"
    order.save!

    redirect_to buyer_manage_path
  end

  def index

  end

  def show

  end

  def new

  end



  def edit

  end

  def update

  end


end
