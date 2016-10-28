require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  # test "should get index" do
  #   get :index
  #   assert_response :success
  # end

  # test "should get show" do
  #   get :show
  #   assert_response :success
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get :destroy
  #   assert_response :success
  # end

  #   #example used was in TaskRails Task Controller, needs fleshing out with fixture info

  #   test "If a user is not logged in they cannot see their task." do
  #   session[:user_id] = nil  # ensure no one is logged in

  #   get :show, id: orders(:SOMEORDER).id
  #   # if they are not logged in they cannot see the resource and are redirected to login.  
  #   assert_redirected session_path
  #   assert_equal "You must be logged in first", flash[:notice]
  # end

  # test "Make sure a user can see their orders" do
  #   session[:user_id] = users(:SOMENAME).id
  #   get :show, id: orders(:SOMENAME).id
    
  #   assert_response :success
  # end

  # test "Make Sure a User Cannot See Another User's Orders" do
  #   session[:user_id] = users(:SOMENAME).id
  #   get :show, id: orders(:SOMEORDER).id
  #   get :show, id: orders(:SOMEORDER).id
    
  #   assert_response :redirect
  #   assert_equal flash[:notice], "You do not have access to that information."
  # end

end
