require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {merchant_id: (products(:glitter).merchant).id, product_id: products(:glitter).id}
    assert_response :success
    assert_template :index
  end

  test "should get show" do
    get :show, {id: reviews(:glitter_review), product_id: products(:glitter).id, merchant_id: (products(:glitter).merchant).id}
    assert_response :success
  end

  test "should get new" do
    get :new, {merchant_id: (products(:glitter).merchant).id, product_id: products(:glitter).id}
    assert_response :success
    assert_template :new
  end

  test "should be able to create a new product" do
    post :create, {merchant_id: (products(:glitter).merchant).id, product_id: products(:glitter).id, review: {description: "njefknlsnf", stars: 2, author: "nfs"}}
    assert_response :redirect
    # This action will need to change to merchant's create_new_product path
  end

  test "creating a product changes the number of products" do
    assert_difference("Review.count",1) do
      post :create, {merchant_id: (products(:glitter).merchant).id, product_id: products(:glitter).id, review: {description: "njefknlsnf", stars: 2, author: "nfs"}}
    end
  end


  test "deleting a review changes the number of reviews" do
    assert_difference("Review.count", -1) do
      delete :destroy, {merchant_id: (products(:glitter).merchant).id, product_id: products(:glitter).id, id: reviews(:glitter_review).id }
    end
  end

  test "redirects and gives flash notice if file isn't found" do
    delete :destroy, {merchant_id: (products(:glitter).merchant).id, product_id: products(:glitter).id, id: 943}
    assert_redirected_to merchant_product_path((products(:glitter).merchant).id, products(:glitter).id)
  end
end
