require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get the new form" do
    get :new, :product_id => 1
    assert_response :success
    assert_template :new
  end

  test "should create a new review and add to the DB" do
    product = products(:elephant)
    assert_difference('Review.count') do
      post :create, review: { rating: 5, description: "BEST EVA!" }, product_id: product.id
    end
    review = assigns(:review)
    assert_not_nil review
    assert_redirected_to product_path(review.product_id)
  end

  test "should not create an invalid review" do
    product = products(:elephant)
    assert_difference('Review.count', 0) do
      post :create, review: { rating: 0, description: "BEST EVA!" }, product_id: product.id
    end

    assert_template :new
  end
end
