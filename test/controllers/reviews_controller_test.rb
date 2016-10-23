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

  # test "should be able to save a review to the database" do
  #   product = products(:cat_suit)
  # end
  #
  # test "should not be able to save a review with empty values" do
  #
  # end
end
