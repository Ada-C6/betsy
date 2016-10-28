require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get new" do
    session[:merchant_id] = products(:one).merchant_id
    get :new

    assert_response :success
    product = assigns(:product)
    assert_not_nil(product)
  end

  test "should create product" do
    session[:merchant_id] = products(:one).merchant_id
    assert_difference('Product.count', 1) do
      post :create, { product: { name: "Test", price: 2.0, quantity: 1, active: true, merchant_id: products(:one).merchant_id} }
    end

    assert_response :redirect
    assert_redirected_to products_path
  end

  test "should redirect to new if invalid product" do
    session[:merchant_id] = products(:one).merchant_id
    post :create, { product: { price: 2.0, quantity: 1, active: true, merchant_id: products(:one).merchant_id} }

    assert_response :bad_request
  end


  test "should show product" do
    get :show, {id: products(:one).id}
    assert_response :success
  end

  test "should get edit" do
    session[:merchant_id] = products(:one).merchant_id
    get :edit, {id: products(:one).id}

    assert_response :success
  end

  test "should update product" do
    session[:merchant_id] = products(:one).merchant_id
    product = products(:one)
    patch :update, { id: product.id, product: {name: "fiddlestick"} }
    assert_not_equal products(:one).name, Product.find(product.id).name
    assert_redirected_to product_path
  end

  test "must update with valid data" do

      session[:merchant_id] = products(:one).merchant_id
      product = products(:one)

      patch :update, { id: product.id, product: {name: ""} }
      assert_response :bad_request


  end

end
