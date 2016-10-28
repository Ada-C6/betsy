require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
    @product = products(:order_test_product_1)
  end

  test "should get new" do
    get :new, product_id: @product
    assert_response :success
  end

  test "should create review" do
    assert_difference('Review.count') do
      post :create, product_id: @product, review: { product_id: 99, review: "lil is rad", rating: 5 }
    end

    assert_redirected_to product_path(assigns(:product))
  end
end
