require 'test_helper'

class OrderitemsControllerTest < ActionController::TestCase
  test "create method should make a new order if there is no session order" do
    session[:order] = nil
    assert_difference('Order.count', 1) do
      post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id, status: 'pending'}
    end
    # Confirm that the session order is now set to the order that holds our new orderitem (most recently added)
    assert session[:order]
    assert_equal session[:order].to_i, Orderitem.last.order.id
  end

  test "create method should not make a new order if there is an existing session order" do
    session[:order] = orders(:testorder1).id
    assert_difference('Order.count', 0) do
      post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id, status: 'pending'}
    end
    assert_equal session[:order].to_i, orders(:testorder1).id
  end

  test "create method should make a new orderitem" do
    # Pre-existing order
    session[:order] = orders(:testorder1).id
    assert_difference('Orderitem.count', 1) do
      post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id, status: 'pending'}
    end
    # No existing order
    session[:order] = nil
    assert_difference('Orderitem.count', 1) do
      post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id, status: 'pending'}
    end
  end

  test "the new orderitem made by create should belong to the appropriate order" do
    # Existing order
    session[:order] = orders(:testorder1).id
    post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id, status: 'pending'}
    assert_equal orders(:testorder1).id, Orderitem.last.order.id
    # No existing order
    session[:order] = nil
    post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id, status: 'pending'}
    assert_equal session[:order].to_i, Orderitem.last.order.id
  end

  test "successful create for an orderitem should redirect to the product page with a confirmatory flash notice" do
    session[:order] = nil
    post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id}
    assert_response :redirect
    assert flash[:notice] == "Item added to cart! Quantity: 1"
    assert_redirected_to products_show_path(products(:farts).id)
  end

  test "unsuccessful creation of an order should redirect to the product page with a descriptive flash notice" do
    # Case where the order stored in the session is not in the database
    session[:order] = -1
    post :create, {add_to_cart: {quantity: 1}, product_id: products(:farts).id}
    assert flash[:notice] == "The item was not added because your cart could not be found. Your cart has now been reset; please try adding the item again."
    assert_equal session[:order], nil
    # Case where invalid quantity is provided, so the save of the orderitem fails
    session[:order] = nil
    post :create, {add_to_cart: {quantity: -5}, product_id: products(:farts).id}
    assert_equal flash[:notice], "There was an error adding the item to your cart. Please try again."
    assert_equal session[:order], nil
  end

  test "update: should be able to add on to the quantity of an item already in the order" do
    assert_difference('orderitems(:orderitem1).quantity', 1) do
      patch :update, {id: orderitems(:orderitem1).id, add_to_cart: {quantity: 1}}
      orderitems(:orderitem1).reload
    end

    assert_response :redirect
    assert flash[:notice] == 'Item added to cart! Total quantity: 2'
    assert_redirected_to products_show_path(orderitems(:orderitem1).product.id)
  end

  test "update: should be able to update the overall quantity of an item already in the order" do
    assert_difference('orderitems(:orderitem1).quantity', 4) do
      patch :update, {id: orderitems(:orderitem1).id, change_quantity: {quantity: 5}}
      orderitems(:orderitem1).reload
    end

    assert_response :redirect
    assert_equal flash[:notice], 'Quantity updated! Quantity: 5'
    assert_redirected_to carts_index_path
  end

  test "update: should get an error message upon attempting to update quantity of a non-existent orderitem" do
    patch :update, {id: -1, change_quantity: {quantity: 5}}
    assert_response :redirect
    assert_equal flash[:notice], "Sorry, that item in your order was not updated because it could not be found. Please try again."
    assert_redirected_to carts_index_path
  end

  test "destroying an existing orderitem reduces the number of orderitems in the database by one" do
    session[:order] = orderitems(:orderitem1).order.id
    assert_difference('Orderitem.count', -1) do
      delete :destroy, {id: orderitems(:orderitem1).id}
    end

    assert_response :redirect
    assert_equal flash[:notice], "Item removed from cart!"
    assert_redirected_to carts_index_path
  end

  test "destroying an non-existent orderitem results in an error message and does not affect database" do
    session[:order] = orderitems(:orderitem1).order.id
    assert_difference('Orderitem.count', 0) do
      delete :destroy, {id: -1}
    end

    assert_response :redirect
    assert_equal flash[:notice], "Sorry, there was a problem with your cart and the item could not be removed. Please try again."
    assert_redirected_to carts_index_path
  end

  test "destroying an orderitem also causes destruction of the order if and only if no other orderitems are in the order" do
    # This orderitem is not the only item in the order, so the order should not be destroyed
    session[:order] = orderitems(:orderitem1).order.id
    assert_difference('Order.count', 0) do
      delete :destroy, {id: orderitems(:orderitem1).id}
    end
    assert session[:order] != nil
    # This orderitem is the only item in the order, so the order should also be destroyed
    session[:order] = orderitems(:orderitem4).order.id
    assert_difference('Order.count', -1) do
      delete :destroy, {id: orderitems(:orderitem4).id}
    end
    assert session[:order] == nil
  end

  test "destroying an orderitem when the session order is nil blocks deletion and produces an error message" do
    session[:order] = nil
    assert_difference('Orderitem.count', 0) do
      delete :destroy, {id: orderitems(:orderitem1).id}
    end

    assert_response :redirect
    assert_equal flash[:notice], "Sorry, there was a problem with your cart and the item could not be removed. Please try again."
    assert_redirected_to carts_index_path
  end

  test "a mismatch between the session order orderitem's order blocks deletion and produces an error message" do
    session[:order] = orderitems(:orderitem4).order.id
    assert_difference('Orderitem.count', 0) do
      delete :destroy, {id: orderitems(:orderitem1).id}
    end

    assert_response :redirect
    assert_equal flash[:notice], "Sorry, there was a problem with your cart and the item could not be removed. Please try again."
    assert_redirected_to carts_index_path
  end

end
