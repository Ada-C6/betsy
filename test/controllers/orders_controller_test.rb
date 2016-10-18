require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "should get the new form" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "should get the new form for a new order" do
    get :new
    assert_response :success
    assert_template :new

    order = assigns(:order)
    assert_not_nil order
    assert_nil order.id
  end

  test "should get the edit form" do
    album = albums(:mellon_collie)
    get :edit, id: album
    assert_response :success
    assert_template :edit
  end

  # test "the truth" do
  #   assert true
  # end
end
