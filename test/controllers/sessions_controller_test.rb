require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def log_in_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  test "If a user has not registered and tries to log in, they are sent to register page" do
    users(:two).destroy #takes Ada out of database
    log_in_a_user #tries to log in Ada from fixtures
    assert_redirected_to users_new_path
   end

  test "Can log in a user who is already registered" do
    #logs in Ada (which matches a fixture)
    log_in_a_user
    assert_redirected_to index_path
    assert_equal flash[:notice], "successfully logged in!"
   end

  test "If a user logs in twice it doesn't create a 2nd user" do
    assert_difference('User.count', 0) do
      log_in_a_user
    end
    assert_no_difference('User.count',0) do
      log_in_a_user
      assert_response :redirect
      assert_redirected_to index_path
    end
  end

  test "The user can log out if they are logged in" do
    log_in_a_user
    assert_not_nil session[:user_id]
    get :destroy
    assert_nil session[:user_id]
    assert_redirected_to index_path
  end

  test "Trying to log out when you are logged out already doesn't do anything" do
    assert_nil session[:user_id]
    get :destroy
    assert_nil session[:user_id]
    assert_redirected_to index_path
  end
end
