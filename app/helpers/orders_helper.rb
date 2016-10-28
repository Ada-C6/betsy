module OrdersHelper

  def ship_order(item, **kwargs)
    if item.shipped != true
      text = "Ship Order"
      path = ship_order_item_path(item)
      method = :patch
    else
      return "Order shipped"
    end
    link_to text, path, method: method, **kwargs
  end

  def order_time_placed(item)
    order = item.order
    if order.order_status == "pending"
      "Order has not been placed"
    else
      payment_detail = order.payment_detail
      return "Order has no payment details" if payment_detail.nil?
      render_date(payment_detail.time_placed)
    end

  end

end
