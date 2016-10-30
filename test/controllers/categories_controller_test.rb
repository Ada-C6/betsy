require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index page" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get show page if category exists" do
    get :show, {id: categories(:apparel).id}
    assert_response :success
    assert_template :show
  end

  test "should show appropriate error page if requested category does not exist" do
    get :show, {id: -1}
    assert_response :missing
  end

  test "index should be able to load even if a category contains no products" do
    # Disconnect products from the apparel category
    assert categories(:apparel).products.length == 3
    categories(:apparel).products = []
    categories(:apparel).save
    products(:shoes).categories = []
    products(:shoes).save
    assert categories(:apparel).products.length == 0

    # Confirm that index page still displays without errors
    get :index
    assert_response :success
    assert_template :index
  end

  test "index should be able to load even if the first product in a category (used for the tile) has no photo" do
    # Set the first product in the apparel category's photo to nil
    product = categories(:apparel).products.first
    product.photo = nil
    product.save
    assert !categories(:apparel).products.first.photo

    # Confirm that the index page still displays without errors
    get :index
    assert_response :success
    assert_template :index

    # Repeat with photo set to "" instead of nil
    product.photo = ""  # As from empty slot in CSV
    product.save
    assert categories(:apparel).products.first.photo == ""

    get :index
    assert_response :success
    assert_template :index
  end

  test "show for a category should be able to load even if a product in the category has no photo" do
    # Set a product in the apparel category's photo to nil
    product = categories(:apparel).products.first
    product.photo = nil
    product.save
    assert !categories(:apparel).products.first.photo

    # Confirm category show still works for apparel
    get :show, {id: categories(:apparel).id}
    assert_response :success
    assert_template :show

    # Repeat with photo set to "" instead of nil
    product.photo = ""  # As from empty slot in CSV
    product.save
    assert categories(:apparel).products.first.photo == ""

    get :index
    assert_response :success
    assert_template :index
  end

end
