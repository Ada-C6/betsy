require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  test "will delete an item from orderitems when removed" do
    orderitem = order_items(:one)
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: orderitem
    end

    assert_redirected_to order_items_path
  end
end
