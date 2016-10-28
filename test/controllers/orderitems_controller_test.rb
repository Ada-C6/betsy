require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase

   test "should get index" do
     get :index
     assert_response :success
   end

  #  test "should create new order_item" do
  #    assert_difference('OrderItem.count', 1) do
  #      post_params = {order_item: { id: 100000000, quantity: 1, product_id: 2 } }
  #      post :create, post_params
  #    end
   #
  #    product = assigns(:product)
  #    assert_redirected_to product_path(product)
  #    assert_not_nil product
  #  end

  test "will delete an item from orderitems when removed" do
    orderitem = order_items(:one)
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: orderitem
    end

    assert_redirected_to order_items_path
  end

end
