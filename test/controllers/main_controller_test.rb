require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get the main page" do
    get :index
    assert_response :success
    assert_template :index
  end
end
