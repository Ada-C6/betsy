require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    # assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    session[:user_id] = merchants(:one).id

    post_params = {
      name: "unique test",
      photo_url: "www.test.org"
    }
    assert_difference('Category.count', 1) do
      post :create, category: post_params
    end
    assert_redirected_to new_merchant_product_path(session[:user_id])
  end

  test "should show category" do
    category = categories(:one)
    get :show, { id: category.id }
    assert_response :success
  end

  test "should rescue error and redirect_to /errors/category_not_found" do
    category = categories(:one)
    category.id = 980

    get :show, { id: category.id }
    assert_redirected_to "/errors/category_not_found"
  end

  test "should render :new if category isn't saved" do
    post_params = {
      name: "unique test",
    }
    assert_no_difference('Category.count') do
      post :create, category: post_params
    end

    assert_template :new
  end

end
