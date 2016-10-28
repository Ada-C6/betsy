class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:user_account, :buyer_manage, :seller_manage, :pending_orders, :paid_orders, :cancelled_orders, :completed_orders]
  # before_action :find_user only [:show, :edit, :update, :destroy]

#AN IDEA FOR HOW TO LIMIT PRODUCT EDITING?
   # app/controllers/users_controller
    # before_action :require_login
    # ...
    # private
    # def require_login
    #   # do stuff to check if user is logged in
    # end

#============User Account: Buyer Manage=============
  def user_account
    @user = User.find(session[:user_id])
  end

  def buyer_manage
    @user = User.find(session[:user_id])
    @orders = @user.orders
  end

  def show_revenue_count
    @total_revenue = OrderItem.total_revenue(@user_id)
    @total_count = OrderItem.total_count(@user_id)

    @paid_revenue = OrderItem.paid_revenue(@user_id)
    @paid_count = OrderItem.paid_count(@user_id)

    @fulfilled_revenue = OrderItem.fulfilled_revenue(@user_id)
    @fulfilled_count = OrderItem.fulfilled_count(@user_id)

    @cancelled_revenue = OrderItem.cancelled_revenue(@user_id)
    @cancelled_count = OrderItem.cancelled_count(@user_id)
  end
#===========User Account: seller Manage=============
  def seller_manage
    # status = params[:status]
    @user_id = session[:user_id]
    @user = User.find(@user_id)

    show_revenue_count

    # @order_items = OrderItem.by_status(@user_id, status)
    @order_items = OrderItem.joins(:product).where('products.user_id' => @user_id)
  end

  def show_orders_by_status

    @user = User.find(session[:user_id])
    @orders = @user.orders.where(:status => status)
    redirect_to buyer_manage_path
  end

  def get_order_by_status
    status = params[:status]
    @user_id = session[:user_id]
    @user = User.find(@user_id)
    @order_items = OrderItem.by_status(@user_id, status)

    show_revenue_count

    render 'seller_manage'
  end

  def ship_order_item

    order_item = OrderItem.find(params[:order_item_id])
    order_item.status = "fulfilled"

    order_item.save!

    redirect_to action: 'seller_manage'
  end

  def order_by_seller
    order_item = OrderItem.find(params[:order_id])
    @order = order_item.order
  end

#==============User Authenticate=============

  def index
    return User.all
  end

  def show
    # @my_user = User.find{ params[:id].to_i }
  end

  def new
    # @my_user = User.new params[:user]
  end

  def create
  #   @my_user = User.new user_params
  #   if @my_user.save
  #     redirect_to root_path, notice: 'Successfully created user.'
  #   else render :new
  #   end
  end


  def edit
    @my_user = User.find{ params[:id].to_i }
    @path = 'update_path'
  end

  def update
    @my_user = User.find{ params[:id].to_i }
    @params = params
    @my_user.fname = params[:user][:name]
    @my_user.email = params[:user][:email]
    @my_user.street_address = params[:user][:street_address]
    @my_user.city = params[:user][:city]
    @my_user.state = params[:user][:state]
    @my_user.zip = params[:user][:zip]
    @my_user.phone = params[:user][:phone]
    @my_user.merchant = params[:user][:merchant]
    @my_user.provider = params[:user][:provider]
    @my_user.status = params[:user][:status]
  end

#really is 'deactivate'
  def destroy
    @my_user = User.find{ params[:id] }
    @my_user.status = false
    @my_user.save
  end


private

  def find_user
    # @my_user = User.find{ params[:id] }
  end

  def user_params
    # params.require(:user).permit :email, :password, :password_confirmation
  end

  def authenticate_user!
    if !session[:user_id]
      flash[:error] = "You must be signed in"
      return redirect_to root_path
    end
  end
end
