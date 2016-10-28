require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

  test "should get a list of categories" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should show the requested category" do
    category_id = categories(:one).id
    get :show, id: category_id
    assert_response :success
    assert_template :show
    assert_equal assigns(:category), categories(:one)
  end

  test "should get the new form when a logged-in User create a new category" do
    session[:merchant_id] = merchants(:one).id
    get :new
    assert_response :success
    assert_template :new

    category = assigns(:category)
    assert_not_nil category
    assert_nil category.name
  end

  test "should create a new Category after a logged-in User fill in the form and submit" do
    session[:merchant_id] = merchants(:one).id
    assert_difference('Category.count', 1) do
      post_params = { category: { name: "Phone"}}
      post :create, post_params
    end
    assert_redirected_to categories_path
    assert_response :redirect
  end

  test "cannot create an new Category without valid inputs and will render the new form" do
    session[:merchant_id] = merchants(:one).id
    assert_no_difference('Category.count') do
      post_params = { category: { name: nil }}
      post :create, post_params
    end
    assert_template :new
    assert_response :success
  end
end
