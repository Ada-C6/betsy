require 'test_helper'

# Testing has and belongs to many relationships:
# http://stackoverflow.com/questions/984566/rails-has-and-belongs-to-many-is-confusing-me-with-fixtures-and-factories

class HomepagesControllerTest < ActionController::TestCase
  test "should get index page" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get show page" do
    get :show
    assert_response :success
    assert_template :show
  end

  test "index should be able to load even if a category contains no products" do
    # Disconnect products from category
    assert categories(:apparel).products.length == 2
    categories(:apparel).products = []
    categories(:apparel).save
    products(:shoes).categories = []
    products(:shoes).save
    assert categories(:apparel).products.length == 0

    # Confirm that the page still displays without errors
    get :index
    assert_response :success
    assert_template :index
  end

  test "index (showing categories) should be able to load even if a category's first product has no photo" do
    # Delete the photo of the first item in the apparel category
    product = categories(:apparel).products.first
    product.photo = nil
    product.save
    assert !categories(:apparel).products.first.photo

    #Confirm the page still displays
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

  test "the page showing all items should be able to load even if a product has no photo" do
    # Set a product's photo to nil
    product = categories(:apparel).products.first
    product.photo = nil
    product.save
    assert !categories(:apparel).products.first.photo

    # Confirm page still displays without errors
    get :show
    assert_response :success
    assert_template :show

    # Repeat with photo set to "" instead of nil
    product.photo = ""  # As from empty slot in CSV
    product.save
    assert categories(:apparel).products.first.photo == ""

    get :show
    assert_response :success
    assert_template :show
  end
end
