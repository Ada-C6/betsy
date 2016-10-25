require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test 'should always succeed' do
    assert true
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, { id: users(:rbg).id }
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: users(:rbg).id }
    assert_response :success
  end

  test "should be able to update a user" do
    get :update, { id: users(:ss).id }
    assert_response :success
  end

  test "should be able to deactivate a user (i.e., destroy)" do
    get :destroy
    assert_response :success
  end

#FOR ALL OTHER CONTROLLERS
  # test "If a user is not logged in they cannot see their task." do
  #   session[:user_id] = nil  # ensure no one is logged in

  #   get :show, id: tasks(:grace_task).id
  #   # if they are not logged in they cannot see the resource and are redirected to login.  
  #   assert_redirected session_path
  #   assert_equal "You must be logged in first", flash[:notice]
  # end

  # test "Make sure a user can see their tasks" do
  #   session[:user_id] = users(:grace_hopper).id
  #   get :show, id: tasks(:grace_task).id
    
  #   assert_response :success
  # end

  # test "Make Sure a User Cannot See Another User's Tasks" do
  #   session[:user_id] = users(:weili_dai).id
  #   get :show, id: tasks(:grace_task).id
  #   get :show, id: tasks(:grace_task).id
    
  #   assert_response :redirect
  #   assert_equal flash[:notice], "You do not have access to that task."
  # end


end
