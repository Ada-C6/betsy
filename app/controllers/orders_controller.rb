class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show

    #get list of items for this guest or merchant_id
    @order_items = LineItem.where(order_id: current_cart.id)

  end

  def new
  end

  def create
  end






  def edit
  end

  def update
    cart = current_cart
    cart.card_name = params[:card_name]
    cart.card_exp = params[:card_exp]
    cart.shipping_street = params[:shipping_street]
    cart.shipping_city = params[:shipping_city]
    cart.shipping_state = params[:shipping_state]
    cart.card_number = params[:card_number].chars.last(4).join
    cart.card_cvv = params[:card_cvv]
    cart.billing_zip = params[:billing_zip]
    cart.shipping_zip = params[:shipping_zip]
    cart.order_status = "Paid"
    cart.total_amount = current_cart.total_amount
    cart.save
    end

  def destroy
    @order_items = LineItem.destroy(params[:id])
    redirect_to action:"show"
  end

 def find_product
   #cusomer product page and clicks add product_id
   Product.find_by(id: params[:product_id] || params[:id])
   #need to take the id use it to find product
 end

   def add_to_cart
     product = find_product
     cart = current_cart
     cart.add_product(product, params[:qty])
    #  current_cart.add_product(find_product)
    redirect_to root_path
   end



    # def remove_from_cart
    #   @line = @order.line_items.find(params[:id])
    #     @line.id.destroy(params[:id].to_i)
    # end

    def update_qty
      line_item = LineItem.find(params[:line_item_id])
      line_item.update(qty: params[:qty])
      redirect_to order_path(current_cart.id)
    end


    def checkout
    end

    

end#end of class
