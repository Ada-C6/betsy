require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:one)
  end

  test "should get new" do

    get :new, product_id: reviews(:one).product_id

    assert_response :success
    review = assigns(:product_review)
    assert_not_nil(review)

  end

  test "should create review" do
    product_id = reviews(:one).product_id
    assert_difference('Review.count') do
      post :create, { review: { rating: 3, product_id: product_id}, product_id: product_id }
    end
    assert_redirected_to product_path(product_id)
  end

  
end
