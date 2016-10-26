require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get the new form for a new review" do

    get :new, id: @review, product_id: review.product_id
    assert_response :success
    assert_template :new

    # review = assigns(:review)
    # assert_not_nil review
  end

  test "should create a new review and add to the DB" do
    product = products(:elephant)
    assert_difference('Review.count') do
      post :create, review: { rating: 5, description: "BEST EVA!" }, product_id: product.id
    end
    review = assigns(:review)
    assert_not_nil review
    assert_redirected_to product_path
  end


  # test "should show post" do
  #   get :show, id: @post, blog_id: @post.blog_id
  #   assert_response :success
  # end

end
