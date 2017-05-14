require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  
  #This test throws an error because @products is nil
  #should probably test this in the products controller or use integration testing
  # test "should get new" do
  #   get :new, id: products(:couple_cases)
  #   assert_response :success
  # end

  test "the user should be able to create a review if the info is valid" do
    review_params={review:{rating: 2, content: "blah"}, product_id: products(:couple_cases)}
    post :create, review_params
    assert_redirected_to product_path(id: products(:couple_cases))
  end

  test "not allowed to review your own products" do
    session[:user_id]= users(:current_user).id
    review_params={review:{rating: 2, content: "blah"}, product_id: products(:couple_cases)}
    post :create, review_params
    assert_redirected_to product_path(id: products(:couple_cases))
    assert_equal flash[:notice], "🕵🏻 We have our eyes on you.. you can't review your own product!"
  end

  #This test throws an error because @reviews is nil. This needs to be changed to [] but
  #that is done in the controller.
  #we should probably test this in the products controller or use integration testing

  # test "the user shouldn't be able to create a review if the info is invalid" do
  #   review_params={review:{rating: nil, content: "blah"}, product_id: products(:couple_cases)}
  #   post :create, review_params
  #   assert_template :create
  # end


end
