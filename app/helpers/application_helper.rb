module ApplicationHelper

  def active_for_button(object)
    # this looks counterintuitive, sorry! It's a view helper method to show the correct text on the button to mark a user active/inactive from the users index page for an admin.
    if object.active
      return "inactive"
    else
      return "active"
    end
  end

  def cart_count
    if !@user.nil?
      @order = Order.find_by user_id: @user.id, order_status: 'cart'
      @cart_count = @order.order_products.length
      return @cart_count
    else
      return "0"
    end
  end
end
