require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_by_category" do
    get :show_by_category
    assert_response :success
  end

  test "should get show_all_products" do
    get :show_all_products
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get show_by_merchant" do
    get :show_by_merchant
    assert_response :success
  end

end
