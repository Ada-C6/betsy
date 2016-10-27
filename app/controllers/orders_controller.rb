class OrdersController < ApplicationController
  before_action :find_order, only: [:edit, :update]
  #before_action :paid_order_status, only: [:update]

  # def index; end # this will show order for only that merchant. Like auth hash - takes from session

  def show
    begin
      @order = Order.find(params[:id])
    rescue StandardError => err
      render "/errors/not_found", status: :not_found
    end

    @order_items = current_order.order_items
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(post_params)
    if @order.save
      redirect_to root_path(@order)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @order.update(post_params)
      redirect_to order_path
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id]).destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:order).permit(:name, :email, :street_address, :city, :state, :mailing_zip, :cc_number, :cc_exp_month, :cc_exp_year, :cc_sec_code, :billing_zip)
  end

  def find_order
    @order = Order.find(params[:id])
  end



  def paid_order_status
    @order.order_status = "paid"
    @order.save
  end

end
