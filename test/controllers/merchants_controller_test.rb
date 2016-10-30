require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase

  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, merchant: { email: "a@b.com", name: "Ada", id: 123545 }
  end

  test "if a guest tries to access merchant show page, redirected to login failure" do
    session[:user_id] = nil  # ensure no one is logged in

    get :show, id: merchants(:snoopy).id
    # if they are not logged in they cannot see the resource and are redirected to login.
    assert_redirected_to login_failure_path
    assert_equal "You must be logged in to view this section", flash[:error]
  end

  # test "should show the view page for the specified merchant" do
  #   login_a_user
  #
  #   get :show, {session[:user_id => 123545]}
  #   puts request.GET.inspect
  #   assert_response :success
  #   assert_template :show
  #
  #   merchant = assigns(:merchant)
  #   assert_not_nil merchant
  #   assert_equal merchant.id, merchant_id
  # end

  # test "should show the show page for the specified product" do
  #   login_a_user
  #   # product_id = products(:elephant).id
  #   get :show#, { id: product_id }
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
