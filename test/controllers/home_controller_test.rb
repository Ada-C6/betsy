# INTERNAL_NOTE: this test ought to pass once we make the home index page available to a guest user. 100% simplecov on this controller as of 10.25.2016.

require 'test_helper'

class HomeControllerTest < ActionController::TestCase
    test "should get index" do
        get :index
        assert_response :success
      end
end
