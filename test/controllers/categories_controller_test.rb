require 'test_helper'


class CategoriesControllerTest < ActionController::TestCase

  def login_a_user
    session[:user_id] = users(:lil).id
  end

  def logout_a_user
    session[:user_id] = nil
  end

  test "should display all categories" do
     get :index
     assert_response :success
     assert_template :index
  end

  test "should show the requested category" do
    @category = categories(:one)
    get :show, { id: categories(:one).id }
     assert_response :success
     assert_template :show

    assert_equal assigns(:category), categories(:one)
  end


  #how do i test products for each category?


  test "should retrieve form to create a new category" do
    login_a_user
    get :new
    assert_template :new
  end

  test "should allow you to create a new category if it does not already exist" do
    login_a_user
    post_params = { category: { name: "drinkalotsalot" } }
    puts "Session id is #{session[:user_id]}"
    assert_difference('Category.count', 1) do
      post :create, post_params
    end

    assert_response :redirect
    assert_redirected_to categories_path
  end

  test "should not create a new category if it already exists" do
    login_a_user
    post_params = { category: { name: "drinkalicious" } }
    post :create, post_params

    assert_difference('Category.count', 0) do
      post :create, post_params
    end

    assert_template :new
  end

  test "should require login to add category" do
    logout_a_user
    post_params = { category: { name: "drinkalicious" } }

    assert_difference('Category.count', 0) do
      post :create, post_params
    end

    assert_not_nil flash[:error]

    assert_redirected_to root_path
  end

  #  assert_equal assigns(:categories), categories(:one)

 end
