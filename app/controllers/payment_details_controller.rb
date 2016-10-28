class PaymentDetailsController < ApplicationController
    before_action :get_payment_details, only: [:show]
    before_action :get_order, only: [:create]
    skip_before_action :require_login

  def show
    @order = @payment_details.order
    @order_items = @order.order_items
    @total_order_price = OrderItem.sum_total_prices(@order_items)
  end

  def new
    @payment_details = PaymentDetail.new
  end

  def create
    @payment_details = PaymentDetail.new(payment_details_params)
    @payment_details.set_order_id(session[:order_id])
    @payment_details.record_time_placed
    if @payment_details.save
      reset_session_values
      update_order_status
      @order.decrease_products_stock
      redirect_to @payment_details
    else
       render :new
    end
  end

  private
    def get_payment_details
      @payment_details = PaymentDetail.find(params[:id])
    end

    def get_order
      @order = Order.find(session[:order_id])
    end

    def payment_details_params
      params.require(:payment_details).permit(:buyer_name, :email, :cc_expiration_date, :cc_four_digits, :city, :email, :state, :street, :zip)
    end

    def reset_session_values
      session[:order_id] = nil
      session[:product_id] = nil
    end

    def update_order_status
      order = Order.find(params[:order_id])
      order.mark_order_paid
      unless order.save
      flash[:error] = "Could not mark order paid"
      end
    end
end
