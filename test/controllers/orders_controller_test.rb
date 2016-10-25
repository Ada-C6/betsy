require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  # CREATE!!!
  test "should be able to create a new order" do
    post_params = {product_id: products(:three).id, order: {status: "pending"}}
    post :create, post_params
    assert_response :redirect
  end

  test "creating a new order should increase the number of orders by 1" do
    assert_difference 'Order.count', 1 do
      post_params = {product_id: products(:three).id, order: {name: orders(:three_pending).name}}
      post :create, post_params
    end
  end

  test "will send back to product#show if stock_quantity is zero" do
    # is this a model test?
  end

  test "will remove one item from stock_quantity when order is created" do
    # model test?
    # remember to return this product item if cancelled
  end

  # test "it can not create more than one order per session" do
  #   # @todo COME BACK here!!!!!
  # end





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
