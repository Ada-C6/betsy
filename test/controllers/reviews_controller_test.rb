require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should be able to view the form to add a new review" do
    product = products(:cat_suit)
    ex_review = reviews(:one_star)
    all_reviews = product.reviews

    get :new, {product_id: product.id}
    assert_response :success
    assert_template :new
    assert_template partial: "_form"
  end

  test "should be able to save a review to the database" do
    product = products(:cat_suit)
    review = { review: {rating: 1, description: "ugh"}, product_id: product.id }

    assert_difference("Review.count", 1) do
      post :create, review
    end

    assert_redirected_to product_path(product.id)

  end

  test "should not save an invalid review to the database" do
    product = products(:cat_suit)
    review = { review: {rating: 1}, product_id: product.id }

    assert_no_difference("Review.count") do
      post :create, review
    end

    assert_template :new
  end
end
