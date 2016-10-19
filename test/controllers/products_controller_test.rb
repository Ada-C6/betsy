require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should show the index page" do
    get :index
    assert_template :index
    assert_response :success

  end

  test "show should a specific product" do
    get :show, {id: products(:cat_suit).id}
    assert_response :success
    assert_template :show
    assert_equal assigns(:product), products(:cat_suit)
  end
end
