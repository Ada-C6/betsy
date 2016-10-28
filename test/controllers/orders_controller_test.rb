require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "should get the index page" do
    get :index
    assert_template :index
    assert_response :success
  end

  test "should get show" do
    order_id = orders(:valid_order).id
    get :show, {id: order_id}
    assert_response :success
  end

  test "should get create" do
    order = orders(:valid_order)
    get :create, {id: order.id}
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
