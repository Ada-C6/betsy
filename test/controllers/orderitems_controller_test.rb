require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase

   test "should get index" do
     get :index
     assert_response :success
   end

   test "should create new order_item" do
     assert_difference('OrderItem.count', 1) do
       post_params = {order_item: { id: 100000000, quantity: 1, product_id: 2 } }
       post :create, post_params
     end

     order_item = assigns(:order_item)
     assert_redirected_to order_items_path
     assert_not_nil order_item
   end

   test "should update order item" do
     order_item = order_items(:one)
     patch :update, id: order_item, order_item: { quantity: order_item.quantity }
     assert_redirected_to order_items_path
   end

  test "will remove an item from order items when deleted" do
    order_item = order_items(:one)
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: order_item
    end

    assert_redirected_to order_items_path
  end

end
