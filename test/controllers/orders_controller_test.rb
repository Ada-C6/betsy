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
    order = orders(:ian)
    get :edit, id: order
    assert_response :success
    assert_template :edit
  end

  test "should create new order" do
    post_params = {order: { name: "Igor Smith", email: "hello@gmail.com", street_address: "38 Main St",
    city: "Seattle", state: "WA", mailing_zip: "98102", cc_number: "1223456743254456",
    cc_exp_month: 5, cc_exp_year: 2017, cc_sec_code: 328, billing_zip: "98102" } }
    assert_difference('Order.count') do
      post :create, post_params
    end

    order = assigns(:order)
    assert_redirected_to root_path(order)
    assert_not_nil order
  end

  test "should update order" do
    order = orders(:buffy)
    patch :update, id: order, order: { name: order.name, email: order.email, street_address: order.street_address, city: order.city,
      state: order.state, mailing_zip: order.mailing_zip, cc_number: order.cc_number, cc_exp_month: order.cc_exp_month, cc_exp_year: order.cc_exp_year,
      cc_sec_code: order.cc_sec_code, billing_zip: order.billing_zip}
    assert_redirected_to order_path
  end

  test "should render edit if update doesn't save" do
    order = orders(:xander)
    patch :update, id: order, order: { name: "", email: order.email, street_address: order.street_address, city: order.city,
      state: order.state, mailing_zip: order.mailing_zip, cc_number: order.cc_number, cc_exp_month: order.cc_exp_month, cc_exp_year: order.cc_exp_year,
      cc_sec_code: order.cc_sec_code, billing_zip: order.billing_zip }
      assert_template :edit
  end

  test "should show the show page for the specified order" do
    order_id = orders(:xander).id
    get :show, { id: order_id }
    assert_response :success
    assert_template :show

    order = assigns(:order)
    assert_not_nil order
    assert_equal order.id, order_id
  end

  test "should show 404 error for invalid order id" do
    order_id = 1346134598    # Bogus ID shouldn't be in DB, otherwise test is invalid
    assert_raises StandardError do
      Order.find(order_id)
    end

    get :show, { id: order_id }
    assert_response :not_found
  end

  test "cannot add invalid order to DB" do
    assert_difference('Order.count', 0 ) do
      post_params = {order: { email: "m@gmail.com", street_address: "123 yolo st", city: "Seattle", state: "WA", mailing_zip: "98126", cc_number: "1223456743254456", cc_exp_month: 5, cc_exp_year: 2017, cc_sec_code: 328, billing_zip: 98126 }}
      post :create, post_params
    end

    assert_template :new
  end

  test "will delete an order from the DB" do
    order = orders(:buffy)
    assert_difference('Order.count', -1) do
      delete :destroy, id: order
    end

    assert_redirected_to root_path
  end
end
