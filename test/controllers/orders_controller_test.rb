require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  # CREATE!!!
  test "should be able to create a new order" do
    post :create, {order: {status: "pending"}}
    assert_response :redirect
  end

  test "creating a new order should increase the number of orders by 1" do
    assert_difference 'Order.count', 1 do
      post :create, {order: {status: "pending"}}
    end
  end

  test "it can not create more than one order per session" do
    # @todo COME BACK here!!!!!
  end



#
#   test "should get show" do
#     get :show, id: orders(:one).id
#     assert_response :success
#   end
#
#   #is this really necesary because won't this happen when the order_item is edited. I didn't think anything else in the order could be edited. I am not really sure what is meant on the excel sheet. Maybe this is referring to editing the status?
#   test "should get edit" do
#     get :edit, id: orders(:one).id
#     assert_response :success
#   end
#
#   test "should update the order when the order_item changes" do
#   end
#
#
#   # Return to non-restful routes.
#   test "an order is marked completed when all items in the order have been shipped" do
#
#   end
#
#   test "an order is cancelled when the session ends before being paid for" do
#
#   end
#
#   test "an order is paid for when the CC info is provided" do
#
#   end
end
#
# # create edit show update completed cancelled paid
