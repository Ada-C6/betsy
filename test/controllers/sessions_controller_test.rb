require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should redirect to login failure path if the merchant isn't found" do
    # if auth_has['uid'].nil?
    #   assert_redirected_to { controller: 'sessions' action: 'create' }
    # end
  end
end
