require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase

  test "should get index" do
    session[:order_id] = order_items(:reduce_quantity2).order_id
    get :index, order_id: order_items(:reduce_quantity2).order_id
    assert_template :index
    assert_response :success
  end

  test "should show order_item" do
    get :show, id: order_items(:reduce_quantity2).id
    assert_template :show
    assert_response :success
  end

  test "should update order_item" do
    order_item = order_items(:reduce_quantity2)
    patch :update, { id: order_item.id, order_item: { quantity: 10} }
    assert_not_equal order_items(:reduce_quantity2).quantity, OrderItem.find(order_item.id).quantity
    assert_redirected_to order_order_items_path(order_item.order)
  end

  test "should destroy order_item" do
    order_item = order_items(:reduce_quantity2)
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: order_item.id
    end
    assert_redirected_to order_order_items_path(order_item.order)
  end

  test "should mark order_item as shipped" do
    order_item = order_items(:not_shipped_item3)
    patch :update, { id: order_item.id, order_item: { shipped: true } }
    assert_not_equal order_items(:not_shipped_item3).shipped, OrderItem.find(order_item.id).shipped
    assert_redirected_to order_order_items_path(order_item.order)
  end
end
