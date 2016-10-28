require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get the new form" do
    get :new, :product_id => 1
    assert_response :success
    assert_template :new
  end

  test "should create a new review and add to the DB" do
    product = Product.create(name: "Elephant", price: 100200, inventory: 2, description: "Elephants are good", photo_url: "elephants.jpeg", active: true, merchant_id: 1, id: 1)
    assert_difference('Review.count') do
      post_params = {id: product.id, review: {description: "gsdg", rating: 4, product_id: product.id} }
      post :create, post_params
    end
    review = assigns(:review)
    assert_not_nil review
    assert_redirected_to product_path(review.product_id)
  end

  test "should not create a review with missing fields" do
    product = Product.create(name: "Elephant", price: 100200, inventory: 2, description: "Elephants are good", photo_url: "elephants.jpeg", active: true, merchant_id: 1, id: 1)
    assert_difference('Review.count', 0) do
      post_params = {id: product.id, review: {description: "gsdg", product_id: product.id} }
      post :create, post_params
    end
    assert_template :new
  end

  # test "merchant should not be able to review their own product" do
  #   product = Product.create(name: "Elephant", price: 100200, inventory: 2, description: "Elephants are good", photo_url: "elephants.jpeg", active: true, merchant_id: 1, id: 1)
  #   @current_user && @current_user.id = product.merchant_id
  #   assert_redirected_to product_path(product)
  #
  # end
end
