require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index, {merchant_id: (products(:glitter).merchant).id}
    assert_response :success
    assert_template :index
  end

  test "should get show" do
    merchant = products(:glitter).merchant

    get :show, {id: products(:glitter).id, merchant_id: merchant.id }
    #get merchant_product_path(merchant.id, products(:glitter).id)
    assert_response :success
  end

  test "should get new" do
    get :new, {merchant_id: (products(:glitter).merchant).id}
    assert_response :success
    assert_template :new
  end

  test "should be able to create a new product" do
    post_params =  {name: "Glitter Wand", description: "a glittery wand", price: "15.00", image: 'http://placekitten.com/200/300', merchant_id: 2, inventory: 7, rating: 5}

    post :create, {merchant_id: (products(:glitter).merchant).id, product: post_params}
    assert_response :redirect
  end

  test "creating a product changes the number of products" do
    assert_difference("Product.count",1) do
      post :create, {merchant_id: (products(:glitter).merchant).id,  "product" => {name: "Glitter Wand", description: "a glittery wand", price: "15.00", image: 'http://placekitten.com/200/300', inventory: 7, rating: 5}}
    end
  end

  test "should get edit -----!!!!" do
    product = products(:glitter)
    get :edit, {id: product.id, merchant_id: products(:glitter).merchant.id }
    assert_response :success
  end

  test "should be able to update a product" do
    put :update, {merchant_id: (products(:glitter).merchant).id, id: products(:glitter).id, product: {name: "Glitter Wand", description: "a glittery wand", price: "15.00", image: 'http://placekitten.com/200/300', merchant_id: 2, inventory: 7, rating: 5}}
    assert_redirected_to controller: "products", action: "show"
  end

  test "deleting a product changes the number of products" do
    assert_difference("Product.count", -1) do
      delete :destroy, {merchant_id: (products(:glitter).merchant).id, id: products(:glitter).id }
    end
  end

  test "responds with error if file isn't found" do
    delete :destroy, {merchant_id: (products(:glitter).merchant).id, id: 943}
    assert_response :missing
  end

end
