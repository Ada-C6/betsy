require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase

  test "should show the view page for the specified merchant" do
    merchant_id = merchants(:snoopy).id
    get :show, { id: merchant_id }
    assert_response :success
    assert_template :show

    merchant = assigns(:merchant)
    assert_not_nil merchant
    assert_equal merchant.id, merchant_id
  end

  # test "should show the show page for the specified product" do
  #   product_id = products(:elephant).id
  #   get :show, { id: product_id }
  #   assert_response :success
  #   assert_template :show
  #
  #   product = assigns(:product)
  #   assert_not_nil product
  #   assert_equal product.id, product_id
  # end

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
