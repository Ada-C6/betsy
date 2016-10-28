require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_merchant
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  def logout_a_merchant
    get :destroy, {provider: "github"}
  end

  test "(create) Can create a merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  test "(create) If a merchant logs in twice it doesn't create a 2nd merchant" do
    login_a_merchant

    assert_no_difference('Merchant.count') do
      login_a_merchant
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  test "(delete) Can destroy a merchant" do
      logout_a_merchant
      assert session[:merchant_id].blank?, "merchant_id_should no longer exist"
      assert_response :redirect
      assert_redirected_to root_path
  end

  test "(index) Can find a previously logged in merchant" do
    login_a_merchant
    previous_login = session[:merchant_id]

    logout_a_merchant
    login_a_merchant

    new_login = session[:merchant_id]

    assert new_login == previous_login
  end
end
