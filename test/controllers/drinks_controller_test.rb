require 'test_helper'

class DrinksControllerTest < ActionController::TestCase
    test "any user or guest can view the homepage" do
      get :index
      assert_response :success
      assert_template :index
  end
end
