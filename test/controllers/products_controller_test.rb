require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:narwal)
    @merchant = merchants(:teeny_merchant)
  end

  test "should get products index" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "should get the new form for a new product for that merchant" do
    session[:merchant_id] = @merchant.id
    get :new, merchant_id: @merchant.id
    assert_response :success
    assert_template :new

    new_product = assigns(:product)
    assert_not_nil new_product
  end

  test "should show requested product" do
    get :show, { id: products(:cat).id }
    assert_response :success
    assert_template :show

    assert_equal assigns(:product), products(:cat)
  end

  test "should get edit form for that product for its merchant" do
    session[:merchant_id] = @merchant.id
    get :edit, id: @product.id, merchant_id: @merchant.id
    assert_response :success
    assert_template :edit
  end

  test "should update product" do
    session[:merchant_id] = @merchant.id
    patch :update, :merchant_id => session[:merchant_id], id: @product, product: {stock: 4}
     assert_redirected_to product_path(@product)
  end

end
