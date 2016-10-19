require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase

    # test "should display all merchants" do
    #   get :index
    #   assert_response :success
    #   assert_template 'merchants/index'
    # end

    test "should show a merchant's page" do
      get :show, { id: 1 }
      assert_response :success
    end

end
