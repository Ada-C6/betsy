require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create, { provider: "github" }
  end

  test "can create a Merchant user" do
    assert_difference('Merchant.count', 1) do
      login_a_user
      assert_response :redirect
      assert_redirected_to sessions_log_in_path
      assert_not_nil session[:merchant_id]
    end
  end

  test "logging in twice should not create 2 Merchant users" do
    assert_difference('Merchant.count', 1) do
      login_a_user
    end

    assert_no_difference('Merchant.count') do
      login_a_user
      assert_response :redirect
      assert_redirected_to sessions_log_in_path
      assert_not_nil session[:merchant_id]
    end
  end

  test "a not-logged-in Merchant user cannot see Merchant Control page" do
    session[:merchant_id] = nil
    get :index_log_out
    assert_template 'sessions/index'
    assert_response :success
  end

  test "a logged-out Merchant user will get redirected to Homepage" do
    login_a_user
    delete :destroy
    assert_response :redirect
    assert_redirected_to sessions_log_out_path
    assert_nil session[:merchant_id]
  end

end
