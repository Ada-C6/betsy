require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

#   test "get index shows all orders" do
#    session[:merchant_id] = merchants(:one).id
#    order_one = orders(:one)
#
#    assert_response :success
#   #  assert_template :index
#
# end
  #
  # test "should get new" do
  #   get new_order_url
  #   assert_response :success
  # end
  #
  # test "should create order" do
  #   assert_difference('Order.count') do
  #     post orders_url, params: { order: {  } }
  #   end
  #
  #   assert_redirected_to order_url(Order.last)
  # end
  #
  # test "should show order" do
  #   get order_url(@order)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_order_url(@order)
  #   assert_response :success
  # end
  #
  # test "should update order" do
  #   patch order_url(@order), params: { order: {  } }
  #   assert_redirected_to order_url(@order)
  # end
  #
  # test "should destroy order" do
  #   assert_difference('Order.count', -1) do
  #     delete order_url(@order)
  #   end
  #
  #   assert_redirected_to orders_url
  # end
end
