class OrdersController < ApplicationController
  before_action :get_order, only: [:show, :update, :destroy]
  before_action :get_merchant, except: [:create, :cancel, :update, :destroy]
  skip_before_action :require_login, except: [:index]


  def index
    get_all_merchant_orders
    get_all_merchant_orders_by_status
    filter_displayed_merchant_orders
  end

  def create
    if in_stock?
      require_order
      save_order
      save_order_item
      redirect_to order_order_items_path(@order)
    else
      flash[:error] = "Product is out of stock"
      redirect_to product_path(@product)
    end
  end

 # see below - two ways to cancel an order
  def cancel; end

  def update
  # canceling the order after the order has been purchased
  # updates status to canceled
  # adds stock back
    payment_details = @order.payment_detail
    if @order.update(order_status: "cancelled")
      @order.increase_products_stock
      redirect_to cancelled_order_path
    else
      flash[:error] = "This order could not be cancelled"
      redirect_to order_order_items_path(@order.id)
    end
  end

  def destroy
  # canceling an order before it has been purchased destroys the order
    @order.destroy
    reset_session_values

    redirect_to cancelled_order_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_order
      @order = Order.find(params[:id])
    end

    def get_merchant
        @merchant = Merchant.find(session[:merchant_id])
    end

    def get_all_merchant_orders
    # "Order" to merchant is the order_items they must fulfill
        @order_items = @merchant.get_merchant_orders
    end

    def get_all_merchant_orders_by_status
    # "Order" to merchant is the order_items they must fulfill
      @completed_orders =   @merchant.get_merchant_orders("completed")
      @paid_orders = @merchant.get_merchant_orders("paid")
      @pending_orders =   @merchant.get_merchant_orders("pending")
      @cancelled_orders =   @merchant.get_merchant_orders("cancelled")
    end

    def filter_displayed_merchant_orders
    # "Order" to merchant is the order_items they must fulfill
      if params['commit'].nil?
        @filtered_orders = @merchant.get_merchant_orders
      else
        @filtered_orders = @merchant.get_merchant_orders(params["commit"].downcase)
      end
    end

     # Before create action, check if there is a cart.  If there is, it is assined in "current_order." If not, we make a new order.
    def current_order
      @order ||= Order.find(session[:order_id]) if session[:order_id]
    end

    def require_order
      @order = Order.build_order if current_order.nil?
    end

    def in_stock?
      @product = Product.find(session[:product_id])
      # check_availability returns true or false
      @product.check_availability(1)
    end

    def save_order
      if @order.save
        session[:order_id] = @order.id
      else
        flash[:error] = "Something went really wrong!"
      end
    end

    def save_order_item
      order_item = OrderItem.add_order_item_to_order(@order.id, session[:product_id])
      (flash[:error] = "Couldn't add product to cart") unless order_item.save
    end

    def reset_session_values
      session[:order_id] = nil
      session[:product_id] = nil
    end

end
