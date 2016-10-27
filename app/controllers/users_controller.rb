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

  def user_account
    @user = User.find(session[:user_id])
  end

  def buyer_manage
    @user = User.find(session[:user_id])
    @orders = @user.orders
  end

  def seller_manage
    @user = User.find(session[:user_id])
  end

  def pending_orders
    @user = User.find(session[:user_id])
    @orders = @user.orders.where(:status => "pending")
  end

  def paid_orders
    @user = User.find(session[:user_id])
    @orders = @user.orders.where(:status => "paid")
  end

  def cancelled_orders
    @user = User.find(session[:user_id])
    @orders = @user.orders.where(:status => "cancelled")
  end

  def completed_orders
    @user = User.find(session[:user_id])
    @orders = @user.orders.where(:status => "completed")
  end

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
