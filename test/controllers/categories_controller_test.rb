require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get the new form" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "should show the products within a certain category" do
    category = categories(:big_animals)
    get :show, { category_id: category.id }
    assert_response :success
    assert_template :show

    products = assigns(:products)
    products.each do |product|
      assert_includes product.categories, category
    end
  end

  test "should create a new category" do
    assert_difference('Category.count') do
      post_params = { category: { name: "Large Animals" } }
      post :create, post_params
    end
    category = assigns(:category)
    assert_not_nil category
  end

  test "should not create an invalid category" do
    assert_difference('Category.count', 0) do
      post :create, category: { id: 5 }
    end

    assert_template :new
  end
end
