require 'test_helper'

class OrderitemsControllerTest < ActionController::TestCase
  test "will delete an item from orderitems when removed" do
    orderitem = order_items(:one)
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: orderitem
    end

    assert_redirected_to orderitems_path
  end
end
