require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  def login_nonexisting_user
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github', uid: '99999', info: { email: "new@b.com", nickname: "Na Ada" }
      })
  end

  def logout_a_user
    delete :destroy
  end

  test "Can Create a user" do
    assert_difference('User.count', 1) do
      login_nonexisting_user
      login_a_user
      assert_response :redirect
      assert_redirected_to user_path(session[:user_id])
      assert_not_nil session[:user_id]
    end
  end

  test "If a user logs in twice it doesn't create a 2nd user" do
    assert_difference('User.count', 1) do
      login_nonexisting_user
      login_a_user
    end
    logout_a_user
    assert_no_difference('User.count') do
      login_nonexisting_user
      login_a_user
      assert_response :redirect
      assert_redirected_to user_path(assigns[:user].id)
      assert_not_nil session[:user_id]
    end
  end

  test "If a user logs out they will have restricted access" do
    logout_a_user
    assert_nil session[:user_id]
    assert_response :redirect
    assert_redirected_to root_path
  end

end
