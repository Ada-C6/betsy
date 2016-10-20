class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def view_cart


  end

  def new
  end

  def create
  end

def subtotal
  @order.line_items do |line|
  line_cost = @line.price * @line.qty
  total_amount << line_cost
  return total_amount  
end
    def total_amount
      subtotal
      total_amount.inject { |result, element| result + element }
      return result
    end




  def edit
  end

  def update
  end

  def destroy
  end

  def guest_create_cart
    if current_merchant.nil? && if @order.guest_id.nil?
    @guest = Guest.new
    @guest.save
    @order = Order.new
    @order.guest_id = @guest.id
    @order.order_status = "pending"
    @order.save
    @line = LineItem.new
    @line.order_id = @order.id
    @line.product_id = params[:products][:product_id]
    @line.merchant_id = params[:products][:merchant_id]
    @line.qty = params[:qty]
    @line.price = params[:products][:price]
    @line.save
  else
    add_to_cart
    end
  def add_to_cart
    @line = LineItem.new
    @line.order_id = @order.id
    @line.product_id = params[:products][:product_id]
    @line.merchant_id = params[:products][:merchant_id]
    @line.qty = params[:qty]
    @line.price = params[:products][:price]
    @line.save
    end

    def remove_from_cart
      @line = @order.line_items.find(params[:id])
        @line.id.destroy(params[:id].to_i)
    end
end
