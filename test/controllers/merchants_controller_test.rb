require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase

    # test "should display all merchants" do
    #   get :index
    #   assert_response :success
    #   assert_template 'merchants/index'
    # end

  test "should show a merchant's page" do
    get :show, { id: 1 }
    assert_response :success
  end

  test "cannot add invalid merchant" do
    assert_difference('Merchant.count', 0) do
      merchant_params = {merchant: { username: "Snoopy", email: "snoopy@gmail.com", id: 1 } }
      post :create, merchant_params
    end
    assert_template :new
  end

  test "can create a new merchant" do
    assert_difference('Merchant.count', 1) do
      merchant_params = {merchant: { username: "Yolo", email: "yolo@gmail.com" } }
      post :create, merchant_params
    end
    merchant = assigns(:merchant)
    assert_redirected_to merchant_path(merchant)
    assert_not_nil merchant
  end 



end
