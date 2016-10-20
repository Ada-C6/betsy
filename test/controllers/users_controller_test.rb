require 'test_helper'

class UsersControllerTest < ActionController::TestCase
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

  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

  test "should get edit" do
    get :edit, { id: users(:rbg).id }
    assert_response :success
  end

  test "should be able to update a user" do
    get :update, { id: users(:ss).id }
    assert_response :success
  end

  test "should be able to deactivate a user (i.e., destroy)" do

  end

end
