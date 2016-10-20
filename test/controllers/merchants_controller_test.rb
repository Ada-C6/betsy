require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get show" do
    get :show, {id: merchants(:one).id}
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "Creating a new Merchant changes number of Merchants" do
    assert_difference('Merchant.count', 1) do
      post_params = { merchant: {name: "Lola CherryCola", email: "lola@email.com", password: "lolarocks"} }
      post :create, post_params
    end
    assert_response :redirect
  end

  test "should get create" do
    post_params = { merchant: {name: "merchant3", email: "email_merchant3@email.com", password: "password1111"} }
    post :create, post_params
    assert_response :redirect
  end

  # test "should get edit" do
  #   get :edit, {id: merchants(:one).id}
  #   assert_response :success
  # end

  # test "should be able to update a merchant" do
  #   patch :update, :id => merchants(:one), :merchants => {email: "new_email@email.com"}
  #   assert_equal "new_email@email.com", assigns(:merchant).email
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

end
