require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get the new form for a new review" do
    get :new
    assert_response :success
    assert_template :new

    review = assigns(:review)
    assert_not_nil review
  end

  test "should create a new review and add to the DB" do
    post_params = { review: { rating: 5, product_id: 1, description: "Its furry, and I like it." }}
    assert_difference('Review.count', 1) do
      post :create, post_params
    end

    review = assigns(:review)
    assert_redirected_to product_path(review.product_id)
  end

  
end
