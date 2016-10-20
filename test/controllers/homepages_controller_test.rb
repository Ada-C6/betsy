
require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "assigns the @product_categories" do
    expect(assigns(:product_categories).not_to be_nil
  end

  test "should get show product categories" do
    get :show, id: items(:album_sample).id
    assert_response :success
  end



end
