require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
  end
  end

  test "Creating a Merchant changes number of Merchants" do
    assert_difference('Merchant.count', 1) do
      post_params = {merchant: {name: "Lola CherryCola"}}
      post :create, post_params
    end
    assert_response :redirect
  end

  test "should get create" do
    get :create
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
