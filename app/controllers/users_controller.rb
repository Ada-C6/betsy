class UsersController < ApplicationController
  before_action :find_user
  before_action :check_active
  before_action :check_admin, only: [:new, :create, :index]
  before_action :find_uiq, only: [:edit, :create, :update, :destroy]

  def index ; end

  def show
    @addresses = Address.where(user_id: @user.id)
  end

  def new
    @user = User.new
  end

  def create
    # this should never happen since we are only creating users from github?
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User successfully added."
      redirect_to users_path
    else
      flash[:notice] = "User not created."
      rendirect_to users_path
    end
  end

  def edit ;  end

  def update
    if @user_in_question.update(user_params)
      flash[:notice] = "Information updated successfully."
      if @user != @user_in_question
        redirect_to users_path
      else
        redirect_to account_path
      end
    else
      flash[:notice] = "Your information could not be saved. Please check and try again"
      redirect_to account_edit_path
    end
  end

  def destroy
    @user_in_question.destroy
    redirect_to users_path
  end

  def switch_active
    user = User.find_by(id: params[:id])
    user.toggle_active
    user.save
    redirect_to users_path
  end

  private
  def find_user
    @user = User.find_by(id: session[:user_id])
    if !@user.nil?
      @order = Order.find_by(user_id: @user.id, order_status: 'cart')
      if @order.nil?
        @order = Order.create(user_id: @user.id, order_status: 'cart')
      end
    else
      @order = Order.create(order_status: 'cart')
    end
    return @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birthdate, :phone, :admin, :active, :uid, :provider)
  end

  def check_admin
    if @user.admin
      @users = User.all
    else
      flash[:notice] = "You do not have access to the requested page. Instead, here's your account page."
      redirect_to account_path
    end
  end

  def check_active
    if !@user.active
      flash[:notice] = "Your account is not active. Please contact support to be activated."
      redirect_to root_path
    end
  end

  def logged_in?
    if @user.id.nil?
      return false
    else
      return true
    end
  end

  # when the current user is an admin, find the user's profile that the admin would like to interact with
  def find_uiq
    if params[:id]
      @user_in_question = User.find_by(id: params[:id])
    else
      @user_in_question = @user
    end
  end



end
