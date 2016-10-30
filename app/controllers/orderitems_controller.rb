class OrderitemsController < ApplicationController
  def create
    begin
      if session[:order]
        order = Order.find_by(id: session[:order])
      else
        order = Order.new(status: 'pending')
      end

      if order
        if params[:add_to_cart][:quantity].to_i <= Product.find(params[:product_id]).stock
          orderitem = Orderitem.new(quantity: params[:add_to_cart][:quantity], product_id: params[:product_id], price: Product.find(params[:product_id]).price, status: 'pending')
          order.orderitems << orderitem
          if !order.save || !orderitem.save
            flash[:notice] = "There was an error adding the item to your cart. Please try again."
          else
            session[:order] = order.id
            flash[:notice] = "Item added to cart! Quantity: #{params[:add_to_cart][:quantity]}"
          end
        else
          flash[:notice] = "Sorry, you cannot add that many items to your cart because your cart would exceed available stock."
        end
      else
        session[:order] = nil
        flash[:notice] = "The item was not added because your cart could not be found. Your cart has now been reset; please try adding the item again."
      end
      redirect_to products_show_path(params[:product_id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Sorry, that item could not be found. Please shop our other unicorn products."
      redirect_to categories_index_path
    end
  end

  # This is getting to be a fat controller. Should move to model if time permits.
  def update
    begin
      orderitem = Orderitem.find(params[:id])
      if params[:add_to_cart] # From item page - increase # of items in cart
        if params[:add_to_cart][:quantity].to_i <= orderitem.product.stock - orderitem.quantity
          orderitem.update(quantity: orderitem.quantity += params[:add_to_cart][:quantity].to_i)
          flash[:notice] = "Item added to cart! Total quantity: #{orderitem.quantity}"
          redirect_to products_show_path(orderitem.product)
        else
          flash[:notice] = "Sorry, you cannot add that many items to your cart because your cart would exceed available stock. Your cart already contains #{orderitem.quantity} of this item."
          redirect_to products_show_path(orderitem.product)
        end
      elsif params[:change_quantity] # From cart page - reset # of items to newly input value
        if params[:change_quantity][:quantity].to_i <= orderitem.product.stock
          orderitem.update(quantity: params[:change_quantity][:quantity].to_i)
          flash[:notice] = "Quantity updated! Quantity: #{orderitem.quantity}"
          redirect_to carts_index_path
        else
          flash[:notice] = "Sorry, you cannot put that many items in your cart because the quantity would exceed available stock."
          redirect_to carts_index_path
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Sorry, that item in your order was not updated because it could not be found. Please try again."
      if params[:add_to_cart]
        redirect_to categories_index_path
      else
        redirect_to carts_index_path
      end
    end
  end

  def destroy
    begin
      order = Order.find(session[:order])
      orderitem = Orderitem.find(params[:id])

      if order.id != orderitem.order.id
        raise RuntimeError
      end

      orderitem.destroy
      flash[:notice] = "Item removed from cart!"

      # Destroy the order if cart is now empty
      if order.orderitems == []
        order.destroy
        session[:order] = nil
      end
    rescue ActiveRecord::RecordNotFound, RuntimeError
      flash[:notice] = "Sorry, there was a problem with your cart and the item could not be removed. Please try again."
    end
    redirect_to carts_index_path
  end

  def ship
    @orderitem = Orderitem.find(params[:id])
    @orderitem.status = "Shipped"
    @orderitem.save

    redirect_to orders_index_path
  end
end
