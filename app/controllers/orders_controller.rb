class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :update]

  def index
    @orders = Order.all
  end

  def show
    begin
      @order = Order.find(params[:id])
    rescue StandardError => err
      render "/errors/not_found", status: :not_found
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      redirect_to root_path(@order)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @order.update(order_params)
      redirect_to update_path
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def product_params
    params.require(:order).permit(:name, :email, :street_address, :city, :state, :zip, :cc_number, :cc_exp_month, :cc_exp_year, :cc_sec_code, :billing_zip)
  end

  def find_order
    @order = Order.find(params[:id])
  end
end
