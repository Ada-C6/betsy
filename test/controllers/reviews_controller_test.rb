require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  # should load all review'
  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end

  # test 'should load specific review on show' do
  #   test_review = reviews(:normal_review)
  #   get :show, id: test_review.id
  #   assert_response :success
  # end

  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should update specific review on patch request" do
  #   test_review_update = reviews(:normal_review)
  #   test_review_change = {body: 'This product is a fabulous dohicky that has solved all my consumer product problems'}
  #   patch :update, id: test_review_update.id, review: test_review_change
  #   updated_review = Review.find(test_review_update.id)
  #   assert_equal 'This product is a fabulous dohicky that has solved all my consumer product problems', updated_review.body

  # end

  # test "should redirect get destroy review" do
  #   test_review_destroy = reviews(:normal_review)
  #   get :destroy, id: test_review_destroy.id
  #   assert_redirected_to '/'
  # end

  # test 'review count should decrease by one on destroy' do
  #   assert_difference('Review.count', -1) do
  #     test_review_destroy = reviews(:normal_review)
  #     get :destroy, id: test_review_destroy.id
  #   end
  # rend

  # test "If a user is not logged in they cannot see their review(s)." do
  #   # session[:user_id] = nil  # ensure no one is logged in

  #   # get :show, id: reviews(:review).id
  #   # # if they are not logged in they cannot see the resource and are redirected to login.  
  #   # assert_redirected session_path
  #   # assert_equal "You must be logged in first", flash[:notice]
  # end
end
