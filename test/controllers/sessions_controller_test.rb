require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_user
     request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
     get :create,  {provider: "github"}
  end

  test "Can Create a user" do
    assert_difference('Merchant.count', 1) do
      login_a_user
      assert_response :redirect
      assert_redirected_to portal_path
    end
  end

   test "If a user logs in twice it doesn't create a 2nd user" do
     assert_difference('Merchant.count', 1) do
       login_a_user
     end
     assert_not_nil session[:user_id]
     assert_no_difference('Merchant.count') do
       login_a_user
       assert_response :redirect
       assert_redirected_to portal_path
       assert_not_nil session[:user_id]
     end
   end
end
