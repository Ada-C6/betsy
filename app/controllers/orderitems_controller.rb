class OrderitemsController < ApplicationController
  def create
    if session[:order]
      order = Order.find(session[:order])
    else
      order = Order.new(status: 'pending')
    end

    orderitem = Orderitem.new(quantity: params[:add_to_cart][:quantity], product_id: params[:product_id], status: 'pending')
    order.orderitems << orderitem
    puts order.save
    puts orderitem.save
    session[:order] = order.id
    flash[:notice] = "Item added to cart! Quantity: #{params[:add_to_cart][:quantity]}"
    redirect_to products_show_path(params[:product_id])
  end

  def update
    orderitem = Orderitem.find(params[:id])
    if params[:add_to_cart] # From item page - increase # of items in cart
      orderitem.update(quantity: orderitem.quantity += params[:add_to_cart][:quantity].to_i)
      flash[:notice] = "Item added to cart! Quantity: #{orderitem.quantity}"
      redirect_to products_show_path(orderitem.product)
    elsif params[:change_quantity] # From cart page - reset # of items to newly input value
      orderitem.update(quantity: params[:change_quantity][:quantity].to_i)
      flash[:notice] = "Quantity updated! Quantity: #{orderitem.quantity}"
      redirect_to carts_index_path
    end
  end

  def destroy
    Orderitem.find(params[:id]).destroy
    flash[:notice] = "Item removed from cart!"

    # Destroy the order if cart is now empty
    order = Order.find(session[:order])
    if order.orderitems == []
      order.destroy
      session[:order] = nil
    end

    redirect_to carts_index_path
  end
end
