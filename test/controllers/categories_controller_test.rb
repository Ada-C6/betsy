require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get the new form" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "should show the products within a certain category" do
    # binding.pry
    category = categories(:big_animals)
    get :show, { category_id: category.id }
    assert_response :success
    assert_template :show

    products = assigns(:products)
    products.each do |product|
      assert_includes product.categories, category
    end
  end

  test "should create a new category for a product" do
    product = products(:elephant)
    assert_difference('Category.count') do
      post :create, category: { name: "Large Animals" }, product_id: product.id
    end
    category = assigns(:category)
    assert_not_nil category
    assert_redirected_to merchants_path
  end

  test "should not create an invalid category" do
    product = products(:monkey)
    assert_difference('Category.count', 0) do
      post :create, category: { id: 5 }, product_id: product.id
    end

    assert_template :new
  end
end
