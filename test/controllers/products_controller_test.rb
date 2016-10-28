require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should show the index page" do
    get :index
    assert_template :index
    assert_response :success
  end

  test "show should a specific product" do
    get :show, {id: products(:cat_suit).id}
    assert_response :success
    assert_template :show
    assert_equal assigns(:product), products(:cat_suit)
  end

  test "should return 404 for a product that doesn't exist" do
    product_id = 123448658
    assert_raises ActiveRecord::RecordNotFound do
      Product.find(product_id)
    end

    get :show, {id: product_id}
    assert_response :not_found
  end

  test "should get the new form" do
    merchant_id = merchants(:doctor).id
    get :new
    assert_template :new
    assert_template partial: '_form'
    assert_response :success
  end

  test "create should add a new product to the database" do
    user = merchants(:doctor)
    post_params = {product: {name: "dog sunglasses", description: "too cool!", price: 549, stock: 10}}
    assert_difference("Product.count", 1) do
      post :create, post_params, {user_id: user.id}
    end

    product = assigns(:product)
    assert_redirected_to product_path(product.id)
  end

  test "product with no name can't change the database" do
    user = merchants(:doctor)
    post_params = {product: {description: "too cool!", price: 549, stock: 10}}
    assert_no_difference("Product.count") do
      post :create, post_params, {user_id: user.id}
    end
    assert_template :new
  end

  test "product with no price can't change the database" do
    user = merchants(:doctor)
    post_params = {product: {name: "dog sunglasses", description: "too cool!", stock: 10}}
    assert_no_difference("Product.count") do
      post :create, post_params, {user_id: user.id}
    end
    assert_template :new
  end

  test "product with no stock can't change the database" do
    user = merchants(:doctor)
    post_params = {product: {name: "dog sunglasses", description: "too cool!"}}
    assert_no_difference("Product.count") do
      post :create, post_params, {user_id: user.id}
    end
    assert_template :new
  end

  test "should get the product edit form" do
    product = products(:cat_suit)
    user_id = product.merchant_id
    get :edit, {id: product.id}, {user_id: user_id}
    assert_template :edit
    assert_template partial: '_form'
    assert_response :success

    # product = assigns(:product)
    # assert_not_nil product
    # assert_equal product.id, product_id
  end

  test "update should change the product" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    patch :update, {id: product.id, product: {name: "cat fancy suit"}}, {user_id: merchant_id}
    assert_equal "cat fancy suit", Product.find(product.id).name

    assert_redirected_to product_path
  end

  test "update should not allow empty name" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    patch :update, {id: product.id, product: {name: nil}}, {user_id: merchant_id}
    assert_equal "cat suit", Product.find(product.id).name

    assert_template :edit
  end

  test "update should not allow invalid price" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    patch :update, {id: product.id, product: {price: 0}}, {user_id: merchant_id}
    assert_equal 1234, Product.find(product.id).price

    assert_template :edit
  end

  test "update should not allow empty stock" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    patch :update, {id: product.id, product: {stock: nil}}, {user_id: merchant_id}
    assert_equal 4, Product.find(product.id).stock

    assert_template :edit
  end

  test "destroy should delete the product" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    assert_difference("Product.count", -1) do
      delete :destroy, {id: product.id}, {user_id: merchant_id}
    end

    assert_raises ActiveRecord::RecordNotFound do
      Product.find(product.id)
    end

    assert_redirected_to portal_path
  end

  test "retire should retire the product if the product is active" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    patch :retire, {id: product.id}, {user_id: merchant_id}

    assert_equal false, Product.find(product.id).active

    assert_redirected_to portal_path
  end

  test "retire should activate the product if the product is retired" do
    product = products(:cat_suit)
    merchant_id = product.merchant_id
    patch :retire, {id: product.id}, {user_id: merchant_id}
    assert_equal false, Product.find(product.id).active
    patch :retire, {id: product.id}, {user_id: merchant_id}
    assert_equal true, Product.find(product.id).active
  end
end
