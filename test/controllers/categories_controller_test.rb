require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get show" do
    get :show, {id: categories(:one).id}
    assert_response :success
    assert_template :show
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should be able to create a new category" do
    post_params = {category: {name: "Harry Potter Things"}}
    post :create, post_params
    assert_response :redirect
  end

  test "creating a category changes the number of categories" do

    assert_difference('Category.count', 1) do
      post_params = {category: {name: "A Category"}}
      post :create, post_params
    end
    assert_response :redirect
  end


  test "should get destroy" do

    delete :destroy, {id: categories(:one).id}
    assert_response :redirect
  end


end
