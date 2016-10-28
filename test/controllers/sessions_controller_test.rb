require 'test_helper'

class SessionsControllerTest < ActionController::TestCase  
  def login_a_merchant
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, { provider: "github" }
  end

  test "can login a merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant
      assert_response :redirect
      assert_redirected_to root_path
      assert_not_nil session[:merchant_id]
    end
  end

  test "if a merchant logs in twice, it doesn't create a second merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant
    end
    assert_no_difference('Merchant.count') do
      login_a_merchant
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  test "can logout a merchant" do
    assert_difference('Merchant.count', 1) do
      login_a_merchant
      assert_not_nil session[:merchant_id]
    end
    assert_difference('Merchant.count', -1) do
      delete :destroy
    end

    assert_nil session[:merchant_id]
  end
end
