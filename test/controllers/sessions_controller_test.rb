require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  def logout_a_user
    session.destroy
  end

  test 'user can log in successfully' do
    login_a_user
    assert_response :redirect
    assert_redirected_to root_path
  end

  test 'it does NOT create a 2nd user if their is a second login in attempt from the same user' do
      login_a_user

    assert_no_difference('User.count') do
      login_a_user
      assert_response :redirect
      assert_redirected_to root_path
    end
  end

  test 'when users are logged in, session[:user_id] should exist' do
    login_a_user
    assert_not_nil(session[:user_id])
  end

  # ######## test destroy method ######

  test 'when a session is destroyed, user ends up at root path' do
    login_a_user
    logout_a_user
    assert_nil(session[:user_id])
    assert_response :redirect
  end
end


######### moving these tests down here, because i think they are model tests not controller tests ###########

# user data uniqueness (testing individual data elements)

# test "user addresses should be unique" do
#   login_a_user
#   duplicate_address = login_a_user.address
#   assert_not duplicate_address.valid?
# end


  # test "index_addresses_on_user_id should be unique" do
  #     duplicate_index_addresses_on_user_id = @index_addresses_on_user_id.dup
  #     @index_addresses_on_user_id.save
  #     assert_not duplicate_index_addresses_on_user_id.valid?
  #   end
