require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase

  test "Should render reviews index page for a specific product" do
    product = products(:one)

    get :index, product_id: product.id
    assert_response :success
  end

  test "If there are no reviews for a product, will redirect you to the product show page" do
    product = products(:one)
    product.reviews = []

    get :index, product_id: product.id
    assert_redirected_to product_path(product.id)
  end

  test "Should render reviews new page for a specific product" do
    product = products(:two)

    get :new, product_id: product.id
    assert_response :success
  end

  test "Should return the correct number of reviews for a specific product" do
    product = products(:one)

    assert_equal(product.reviews.count, 2)
  end

  test "Can create a review with a product id and rating" do
    test_product = products(:one)

    assert_difference('Review.count', 1) do
      post :create, product_id: test_product.id, review: { rating: 5, title: "test" }
    end

    assert_redirected_to product_reviews_path
  end

  test "Cannot create a review with an product id and no rating" do
    test_product = products(:one)

    assert_no_difference('Review.count') do
      post :create, product_id: test_product.id, review: { title: "test" }
    end
  end

  test "Cannot create a review with an invalid product id and a valid rating" do
    test_product = products(:one)
    test_product.id = 90008

    assert_no_difference('Review.count') do
      post :create, product_id: test_product.id, review: { rating: 5, title: "test" }
    end
  end
end
