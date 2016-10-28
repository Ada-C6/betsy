class OrdersController < ApplicationController
  before_action :find_user
  before_action :find_uiq, only: [:index, :all]
  before_action :find_order, except: [:index, :new, :create, :all]
  before_action :findAddress, only: [:show]

  def index
    if @user.admin
      @orders = Order.all
    else
      redirect_to user_orders_path(@user.id)
    end
  end

  def show
  end

  def new
    @order = Order.new
  end
  #
  # def create
  #   @order = Order.new(order_params)
  #   if @order.save!
  #     redirect_to # UNKNOWN
  #   else
  #     render # UNKNOWN
  #   end
  # end

  def edit
    if @user.nil?
      # This should be session?
      @order = Order.where(order_status: 'cart')
    else
      @order = Order.find_by user_id: @user.id, order_status: 'cart'
    end
  end

  # Currently only used for checking out. Be careful!
  def update
    if @order.update!(order_params)
      @order.order_products.each do |order_product|
        product = Product.find(order_product.product_id)
        product.inventory_qty -= order_product.qty
        product.save
      end
      redirect_to order_path(@order.id)
      flash[:notice] = "Thank you for your order!"
    else
      flash[:notice] = "Please double-check the fields & try again."
      redirect_to cart_path
    end

    if Order.find_by(user_id: @user.id, order_status: 'cart') == nil
      @order = Order.new(user_id: @user.id, order_status: 'cart')
      @order.save
    end

  end

  def destroy
    @order.destroy
    redirect_to root_path
  end

  def all
    @orders = Order.where(user_id: @user_in_question.id, order_status: 'ordered')
  end

  private
  def find_order
    @order = Order.find(params[:id])
  end

  def find_user
    @user = User.find_by(id: session[:user_id])
    # if @user.nil?
    #   @user = nil
    # end
  end

  def findAddress
    @shipping = Address.find_by(id: @order[:shipping_address_id])
    @billing = Address.find_by(id: @order[:billing_address_id])
  end

  # added
  def order_params
    params.require(:order).permit(:order_status, :shipping_cost, :user_id, :shipping_address_id, :billing_address_id) #changed from user to match model
  end

  def find_uiq
    if params[:id]
      @user_in_question = User.find_by(id: params[:id])
    else
      @user_in_question = @user
    end
  end


end
