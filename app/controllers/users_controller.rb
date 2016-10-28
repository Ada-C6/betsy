class UsersController < ApplicationController
  before_action :require_login, except: [:index, :public_show]
  # before_action :find_user, except: [:index]
  def index
    @users = User.all
  end

  def show
    @status = params[:orderstatus]
    @show = params[:show]

    case @status
    when nil, "all"
      @orders = @user.orders
    when "pending"
      @orders = @user.orders_by_status("pending")
      @revenues = @user.revenues_by_status("pending")
    when "paid"
      @orders = @user.orders_by_status("paid")
      @revenues = @user.revenues_by_status("paid")
    when "completed"
      @orders = []
      @user.orders.each do |order|
        unless order.complete_order_for_user(@user).nil?
          @orders << order
        end
      end
      results = []
      @orders.each do |order|
        order.order_items.map do |item|
          results << item.subtotal if @user.products.include?(item.product)
        end
      end
      @revenues = results.reduce(:+)
    when "cancelled"
      @orders = @user.orders_by_status("cancelled")
      @revenues = @user.revenues_by_status("cancelled")
    end

    case @show
    when "", nil
      @products = @user.products
    when "active"
      @products = @user.products.where(retired: false)
    when "retired"
      @products = @user.products.where(retired: true)
    end
  end

  def public_show
    @user = User.find(params[:id])
    @products = @user.products

  end

  # def new; end
  #
  # def create; end
  #
  # def edit; end
  #
  # def update; end

  private

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to make seller changes" #this only shows if you tell it to show
      redirect_to root_path
    end
  end
end
