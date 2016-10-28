require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  

  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should get create a new order on post request" do
    assert_difference('Order.count', 1) do
      post :create,
      { order: 
        { 
          order_status: 'shipping soon',
          shipping_cost: 1234,
          user_id: 9
        }
      }
    end
  end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should update orders on patch request" do
  #   test_order_update = orders(:normal_order)
  #   test_order_change = {order_status: 'bigWombat'}
  #   patch :update, id: test_order_update.id, order: test_order_change
  #   updated_order = Order.find(test_order_update.id)
  # end
 
  # test "should redirect on orders controller destroy" do
  #   test_order_destroy = orders(:normal_order)
  #   get :destroy, id: test_order_destroy
  #   assert_redirected_to '/'
  # end

  # test "If a user is not logged in they cannot see their order(s)." do
  #   # session[:user_id] = nil  # ensure no one is logged in

  #   # get :show, id: orders(:orders).id
  #   # # if they are not logged in they cannot see the resource and are redirected to login.  
  #   # assert_redirected session_path
  #   # assert_equal "You must be logged in first", flash[:notice]
  # end
end
