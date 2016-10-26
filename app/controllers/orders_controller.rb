class OrdersController < ApplicationController
  def index
    @orders = Merchant.find_by(session[:user_id].to_i).products.orders
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
