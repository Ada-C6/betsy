require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  test "a guest can add an item to their cart if they don't have a cart yet" do
    request.env["HTTP_REFERER"]="blah"
    post :create, id: products(:couple_cases)
    assert_redirected_to "blah"
  end

  test "a guest can add an item to their cart if they already have one" do
    request.env["HTTP_REFERER"]="blah"
    session[:cart_id]=cart_products(:test_cart_item).cart.id
    post :create, id: products(:couple_cases)
    assert_redirected_to "blah"
  end

  test "should get edit" do
    request.env["HTTP_REFERER"]="blah"
    get :edit, id: products(:couple_cases)
    assert_redirected_to "blah"
  end

  test "a user can see their cart" do
    session[:cart_id]=cart_products(:test_cart_item).cart.id
    get :show, id: carts(:one)
    assert_response :success
  end

  test "a user can delete an item in their cart" do
    request.env["HTTP_REFERER"]="blah"
    delete :destroy, id: cart_products(:test_cart_item)
    assert_redirected_to "blah"
  end

  test "a user can empty their cart" do
    request.env["HTTP_REFERER"]="blah"
    delete :empty
    assert_redirected_to "blah"
  end

  test "a user cannot empty an already empty cart" do
    request.env["HTTP_REFERER"]="blah"
    delete :empty
    assert_redirected_to "blah"
     delete :empty
    assert_equal flash[:notice], "You cannot empty and already empty cart!"
  end

  test "a user can increase the quantity of items in their cart" do
    request.env["HTTP_REFERER"]="blah"
    patch :increase, id: cart_products(:test_cart_item)
    assert_redirected_to "blah"
  end
  #ask Leah about this code: elsif @cart_product.product_quantity == @product.quantity
  #I need to know what it means to write a test that hits that line

  test "a user can decrease the quantity of items in their cart to make qty 0" do
    request.env["HTTP_REFERER"]="blah"
    patch :decrease, id: cart_products(:test_cart_item)
    assert_redirected_to "blah"
  end

  test "a user can decrease the quantity of items in their cart to make qty a number other than 0" do
    request.env["HTTP_REFERER"]="blah"
    patch :decrease, id: cart_products(:two_of_them)
    assert_redirected_to "blah"
  end
end
