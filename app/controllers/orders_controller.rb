class OrdersController < ApplicationController
  before_action :require_merchant, only: [:index, :show]

  def index
    merchant = Merchant.find_by(id: session[:user_id].to_i)
    @orders = merchant.orders
  end

  def new
  end

  def create
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    begin
      @order = Order.find(session[:order])
      @order.destroy
      session[:order] = nil
      redirect_to carts_index_path
    rescue ActiveRecord::RecordNotFound
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def update

  end

end
