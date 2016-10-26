require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  test "should get index page" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get show page if store (merchant) exists" do
    get :show, {id: merchants(:bob).id}
    assert_response :success
    assert_template :show
  end

  test "should show appropriate error page if requested store (merchant) does not exist" do
    get :show, {id: -1}
    assert_response :missing
  end

  test "index should be able to load even if a store (merchant) has no products" do
    # Disconnect Bob's only product
    assert merchants(:bob).products.length == 2
    merchants(:bob).products = []
    merchants(:bob).save
    products(:shoes).merchant = nil
    products(:shoes).save

    # Check that the product was fully disconnected
    assert merchants(:bob).products.length == 0
    assert !products(:shoes).merchant

    # Confirm that the page still displays properly
    get :index
    assert_response :success
    assert_template :index
  end

  test "index should be able to load even if a merchant's first product (used for tile) has no photo" do
    # Delete the photo of a merchant's first product
    product = merchants(:bob).products.first
    product.photo = nil
    product.save
    assert !merchants(:bob).products.first.photo

    # Confirm that the page still loads properly
    get :index
    assert_response :success
    assert_template :index

    # Repeat with an empty string instead of nil
    product = merchants(:bob).products.first
    product.photo = ""  # As from empty slot in CSV
    product.save
    assert merchants(:bob).products.first.photo == ""

    get :index
    assert_response :success
    assert_template :index
  end

  test "show should be able to load even if a product has no photo" do
    # Delete the photo of a merchant's first product
    product = merchants(:bob).products.first
    product.photo = nil
    product.save
    assert !merchants(:bob).products.first.photo

    # Confirm that the page still loads properly
    get :show, {id: merchants(:bob).id}
    assert_response :success
    assert_template :show

    # Repeat with an empty string instead of nil
    product = merchants(:bob).products.first
    product.photo = ""  # As from empty slot in CSV
    product.save
    assert merchants(:bob).products.first.photo == ""

    get :show, {id: merchants(:bob).id}
    assert_response :success
    assert_template :show
  end

end
