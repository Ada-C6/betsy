require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "can show user's products and orders" do
    user_id = users(:lil).id
    session[:user_id] = user_id
    user = User.find(user_id)
    product = Product.find(products(:lil_product).id)
    retired = Product.find(products(:lil_product2).id)
    order = Order.find(88)
    order_item = OrderItem.find(order_items(:lil).id)
    get :show, { id: user_id }
    assert_response :success
    assert_template :show
    assert_equal assigns[:user], user
    # assert_equal assigns[:user].id, products(:lil_product).user_id
    assert_includes assigns(:products), product
    # assert_includes assigns(:retired), retired
    assert_includes assigns(:orders), order
    # assert_includes assigns(:order_items), order_item
    get :show, { id: user_id, show: "retired"}
    assert_response :success
    assert_equal assigns(:show), "retired"
    assert_template :show

    get :show, { id: user_id, show: "active"}
    assert_response :success
    assert_equal assigns(:show), "active"
    assert_template :show
  end

  test "will redirect and flash error if not logged in" do
    session[:user_id] = nil
    get :show, { id: 30 }
    assert_not_nil flash[:error]
    assert_response :redirect
    assert_redirected_to root_path
  end

  test "can filter displayed orders by status" do
    user_id = users(:lil).id
    session[:user_id] = user_id
    user = User.find(user_id)

    get :show, { id: user_id, orderstatus: "completed" }
    assert_equal assigns(:status), "completed"
    # assert_includes assigns(:orders), Order.find(orders(:lil_order).id)
    assert_template :show

    get :show, { id: user_id, orderstatus: "pending" }
    assert_equal assigns(:status), "pending"
    assert_template :show

    get :show, { id: user_id, orderstatus: "paid" }
    assert_equal assigns(:status), "paid"
    assert_template :show

    get :show, { id: user_id, orderstatus: "cancelled" }
    assert_equal assigns(:status), "cancelled"
    assert_template :show
  end

  test "should show a list of merchants" do
    get :index
    assert_template 'users/index'
    assert_response :success

  end

  test "guest should be able to see a vendors products" do
    get :public_show, {id: users(:lil).id }
    assert_template 'users/public_show'
    assert_response :success

    assert_equal assigns(:user), users(:lil)
    #add more asserts here? dkl
  end

end
