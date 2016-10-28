require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  

  test 'that the controller populates categories on get' do
    get :index
    assert(@controller.categories.length > 0)
    
  end

  test 'that the controler populates products on get' do
    get :index
    assert(@controller.products.length > 0)
  end

end
