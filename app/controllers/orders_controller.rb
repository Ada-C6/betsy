class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
  end

  def new
  end

  def create
    if current_merchant.nil?
      
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
