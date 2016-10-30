require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get the new form" do
    get :new
    assert_response :success
    assert_template :new
  end

  test "should get the new form for a new product" do
    get :new
    assert_response :success
    assert_template :new

    product = assigns(:product)
    assert_not_nil product
    assert_nil product.id
  end

  test "should get the edit form" do
    product = products(:elephant)
    get :edit, id: product
    assert_response :success
    assert_template :edit
  end

  test "should update product" do
    product = products(:elephant)
    patch :update, id: product, product: { name: product.name, price: 55 }
    assert_redirected_to product_path
  end

  test "should render edit if updating product is unsuccessful" do
    product = products(:elephant)
    patch :update, id: product, product: { name: "", price: "5" }
    assert_template :edit
  end

  test "should create new product" do
    assert_difference('Product.count') do
      post_params = {product: { name: "Tigers", price: 234513, inventory: 5, description: "Yay tigers", photo_url: "tigers.jpeg"} }
      post :create, post_params
    end

    product = assigns(:product)
    assert_redirected_to product_path(product)
    assert_not_nil product
  end


  test "should render new if new product doesn't save" do
    assert_difference('Product.count', 0) do
      post_params = {product: { name: "Tigers", price: 234513, inventory: 5, description: "striped" } }
      post :create, post_params
    end

    assert_template :new
  end


  test "should show the show page for the specified product" do
    product_id = products(:elephant).id
    get :show, { id: product_id }
    assert_response :success
    assert_template :show

    product = assigns(:product)
    assert_not_nil product
    assert_equal product.id, product_id
  end

  test "should redirect to products path if product isn't active" do
    product_id = products(:monkey).id
    get :show, { id: product_id }
    assert_redirected_to products_path
  end

  test "should show 404 error for invalid product id" do
    product_id = 1346134598    # Bogus ID shouldn't be in DB, otherwise test is invalid
    assert_raises StandardError do
      Product.find(product_id)
    end

    get :show, { id: product_id }
    assert_response :not_found
  end

  test "will delete a product from the DB" do
    product = products(:snake)
    assert_difference('Product.count', -1) do
      delete :destroy, id: product
    end

    assert_redirected_to products_path
  end


  # def retire_product
  #   p = Product.find(params[:id])
  #   p.active = false
  #   p.save
  #   redirect_to products_path
  # end

  test "will retire a product from the DB" do
    product = products(:snake)
    assert_equal product.active, true
    product.retire_product
    assert_equal product.active, false
  end




  # test "purchasing a product will decrease its number by one" do
  #   post :purchase, id: products(:elephant).id
  #   product = assigns(:product)
  #   assert_equal product, xxxxxx # Need to have number of products
  # end

  # test "will delete a product from the DB when all are purchased" do
  #   product = products(:elephant)
  #   assert_difference('Product.count', -1) do
  #     delete :destroy, id: product
  #   end
  #
  #   assert_redirected_to products_path
  # end

  # test "will throw an error if products ordered are greater than inventory" do
  #   To be done
  # end

end
