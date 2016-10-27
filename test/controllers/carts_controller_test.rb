require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  test "should get index, whether there is an order stored in the session or not" do
    session[:order] = nil
    get :index
    assert_response :success
    assert_template :index

    session[:order] = orders(:testorder2).id
    get :index
    assert_response :success
    assert_template :index
  end

  test "for index, should update with a message if an item in the cart has changed price" do
    session[:order] = orders(:testorder1).id
    get :index
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert_equal flash[:notice], "Some of your order items have changed in price and have been updated. Please review your order and press 'Check out' or continue shopping."
    assert_equal orderitems(:orderitem2).price, 899
  end

  test "if an order ID is stored in the session but the ID is invalid, the session should be reset and a message displayed" do
    session[:order] = -1
    get :index
    assert_equal flash[:notice], "An error occurred and your cart could not be found. Your cart has been reset so you can continue shopping."
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert !session[:order]
  end

  test "if an order ID is stored in the session, the edit page should display" do
    session[:order] = orders(:testorder2).id
    get :edit
    assert_response :success
    assert_template :edit
  end

  test "for edit, should redirect to index with a message if an item in the cart has changed price" do
    session[:order] = orders(:testorder1).id
    get :edit
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert_equal flash[:notice], "Some of your order items have changed in price and have been updated. Please review your order and press 'Check out' or continue shopping."
    assert_equal orderitems(:orderitem2).price, 899
  end

  test "if no order ID is stored in the session, the edit method should redirect to the carts index with a message" do
    session[:order] = nil
    get :edit
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert_equal flash[:notice], "Your cart is empty! Please add something to your cart before you check out."
  end

  test "if an invalid order ID is stored in the session, the edit method should redirect to the carts index with a message" do
    session[:order] = -1
    get :edit
    assert_equal flash[:notice], "An error occurred and your cart could not be found. Your cart has been reset so you can continue shopping."
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert !session[:order]
  end

  test "if an invalid order ID is stored in the session, the update method should redirect to the carts index with a message" do
    session[:order] = -1
    get :update
    assert_equal flash[:notice], "An error occurred and your cart could not be found. Your cart has been reset so you can continue shopping."
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert !session[:order]
  end


  # Note: the edit form is not currently gated on any of its values. I.e., we are not checking to see if the user
  # puts in the right thing or even supplies a value. This would be a good thing to do in the next round of edits.

  test "if a valid order ID is stored in the session, update should modify the order and show the update page" do
    session[:order] = orders(:testorder1).id
    get :update, {order: {name: 'Bill the Cat', address: 'Bloom Boarding House', email: 'bill@thecat.com', city: 'Bloom County', state: 'NA', zip: '00000', card_name: "Berkeley Breathed", card_num: '0000000000000000', cvv: '111', billing_zip: '00000', :'expiry(3i)' => '1', :'expiry(2i)' => '1', :'expiry(1i)' => '2016'}}
    orders(:testorder1).reload

    assert_response :success
    assert_template :update

    assert_equal orders(:testorder1).name, 'Bill the Cat'
    assert_equal orders(:testorder1).card_num, '0000000000000000'
  end

  test "if no order ID is stored in the session, update should redirect to the index with an error message" do
    session[:order] = nil

    get :update, {order: {name: 'Bill the Cat', address: 'Bloom Boarding House', email: 'bill@thecat.com', city: 'Bloom County', state: 'NA', zip: '00000', card_name: "Berkeley Breathed", card_num: '0000000000000000', cvv: '111', billing_zip: '00000', :'expiry(3i)' => '1', :'expiry(2i)' => '1', :'expiry(1i)' => '2016'}}

    assert_response :redirect
    assert_equal flash[:notice], "Sorry, your cart could not be found. Please try again."
  end

  test "if any items have a stock of 0 when a person tries to check out, the items should be removed from the order" do
    session[:order] = orders(:testorder1).id
    products(:shoes).update(stock: 0)

    assert_difference('orders(:testorder1).orderitems.count', -1) do
      get :edit
      orders(:testorder1).reload
    end

    assert_response :redirect
    assert_redirected_to carts_index_path
    assert_equal flash[:notice], "Some of your order items are no longer in stock. The backordered items were removed from your order. Please review your order and press 'Check out' or continue shopping."
  end

  test "if a backordered item is removed and the cart is empty, the order should be deleted" do
    session[:order] = orders(:testorder2).id
    products(:poo).update(stock: 0)

    assert_difference('Order.count', -1) do
      get :edit
    end

    assert !session[:order]
    assert_response :redirect
    assert_redirected_to carts_index_path
    assert_equal flash[:notice], "Some of your order items are no longer in stock. The backordered items were removed from your order. Please review your order and press 'Check out' or continue shopping."
  end

  test "if any items have a stock that is not 0 but too low to fulfill the person's order, the quantity of the item in the order should be reduced to the fulfillable level" do
    session[:order] = orders(:testorder1).id
    products(:poo).update(stock: 1)

    assert_difference('orderitems(:orderitem2).quantity', -1) do
      get :edit
      orders(:testorder1).reload
      orderitems(:orderitem2).reload
    end

    assert_response :redirect
    assert_redirected_to carts_index_path
    assert_equal flash[:notice], "Some of your order items are no longer in stock. The backordered items were removed from your order. Please review your order and press 'Check out' or continue shopping."
  end

end
