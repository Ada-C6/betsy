require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "index displays all the products if no merchant_id or category_id is given" do
    get :index
    assert_response :success
    assert_template :index

    products_from_controller = assigns(:products)
    assert_equal Product.count, products_from_controller.length
  end

  test "index displays all the products for a merchant (when called in the context of a merchant)" do
    # fake a merchant ID in the request
    get :index, merchant_id: merchants(:one).id
    assert_response :success
    assert_template :index

    # Same merchant returned from the index method
    assert_equal assigns(:merchant), merchants(:one)

    products_from_controller = assigns(:products)

    assert_equal products_from_controller.count, merchants(:one).products.count
    # Each product returned belongs to that merchant.
    products_from_controller.each do |product|
      assert_includes merchants(:one).products, product
    end
  end
  test "products#show displays a product if it exists!" do
    #fake a user logged in
    product_id = products(:one).id
    get :show, { id: product_id }

    assert_response :success
    product = assigns(:product)
    assert_not_nil product
    assert_equal product.id, product_id

    #this controller doesn't make a new artist
    assert_no_difference ('Product.count') do
      get :show, { id: product_id }
    end
  end

  test "products#show displays an error page if product does not exist" do
    skip
    # TODO
  end

  test "products#new displays the new form for logged in merchant" do
    #fake a user is logged in.
    session[:user_id] = merchants(:one).id

    get :new, {merchant_id: session[:user_id]}

    assert_response :success
    assert_template :new
  end

  test "products#new is only visible to logged in users" do
    # Ensure there is no logged in user.
    session.delete(:user_id)

    get :new, {merchant_id: merchants(:one).id}
    assert_response :redirect
    assert_redirected_to login_failure_path
  end

  test "can create a valid product (if logged in)" do
    #faking logged in
    session[:user_id] = merchants(:one).id

    product_params =
      { name: "Jammy Jams",
        description: "They make the best jam.",
        price: 349,
        stock_quantity: 1,
        photo_url: 'grapes.jpg',
      }

    # make a new product actually adds a product to the databse.
    assert_difference('Product.count', 1) do
      post :create, merchant_id: session[:user_id], product: product_params
    end

    post :create, merchant_id: session[:user_id], product: product_params


    # TODO: write a test that redirects to product_categories#new path where a customer should add their new product to some categories after they make the product.
  end

  test "cannot create a new product if not logged in" do
    # Ensure there is no logged in user.
    session.delete(:user_id)

    post :create, {merchant_id: merchants(:one).id}
    assert_response :redirect
    assert_redirected_to login_failure_path
  end

  # Need tests for new/create/edit(not done with code yet)
end
