require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end
  #
  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

  # setup do
  #   request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  # end

  def login_a_merchant
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {uid: '12345'}
  end

  test "Can Create a merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant
      assert_response :redirect
      assert_redirected_to merchant_path(Merchant.last.id)
    end
  end

  test "If a merchant logs in twice it doesn't create a 2nd merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant
    end
    assert_no_difference('Merchant.count') do
      login_a_merchant
      assert_response :redirect
      assert_redirected_to merchant_path(Merchant.last.id)
    end
  end
end
