require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @merchant = merchants(:teeny_merchant)
    @product = products(:chair)
    @category = categories(:correct_category)
    @product.categories << @category
  end

  test "Setup should associate category with product" do
    assert_equal @category.products.first, @product
  end

  test "Index should get index and its template" do
    get :index
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:categories)
  end

  test "Only a logged on person can get to the new category form" do
    session[:merchant_id] = @merchant.id
    get :new
    assert_response :success
    assert_template :new
  end

  test "A non-logged on person cannot get to the new form" do
    session[:merchant_id] = nil
    get :new
    assert_template :view_error
  end

  test "A category without a name will raise a parameter missing error" do
    session[:merchant_id] = @merchant.id

    assert_raises(ActionController::ParameterMissing) { post :create, {name: nil, description: "slkdfj"}}
  end

  test "Create should create category" do
    session[:merchant_id] = @merchant.id

    assert_difference('Category.count') do
      post :create, category: { name: "name", description: "q, d, t" }
    end

    assert_redirected_to categories_path
  end

  test "Show should show category with products attached" do
    get :show, id: @category
    assert_response :success
    assert_template :show
    assert_equal @category.products, assigns(:category_products)
  end

end
