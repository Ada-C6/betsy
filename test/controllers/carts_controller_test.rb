require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  test "should get index, whether there is an order stored in the session or not" do
    session[:order] = nil
    get :index
    assert_response :success
    assert_template :index

    session[:order] = orders(:testorder1).id
    get :index
    assert_response :success
    assert_template :index
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
    session[:order] = orders(:testorder1).id
    get :edit
    assert_response :success
    assert_template :edit
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

  # Note: the edit form is not currently gated on any of its values. I.e., we are not checking to see if the user
  # puts in the right thing or even supplies a value. This would be a good thing to do in the next round of edits.

  # test "if a valid order ID is stored in the session, update should modify the order and show the update page" do
  #   session[:order] = orders(:testorder1).id
  #   testhash = {name: 'Bill the Cat', address: 'Bloom Boarding House', email: 'bill@thecat.com', city: 'Bloom County', state: 'NA', zip: '00000', card_name: "Berkeley Breathed", card_num: '0000000000000000', cvv: '111', billing_zip: '00000'}
  #   testhash['expiry(3i)'] = '1'
  #   testhash['expiry(2i)'] = '10'
  #   testhash['expiry(1i)'] = '2016'                                                                                                                                                                                                 #"expiry(3i)"=>"1", "expiry(2i)"=>"10", "expiry(1i)"=>"2016"
  #   get :update, {order: testhash}
  #   assert_response :success
  #   assert_template :update
  #   assert_equal orders(:testorder1).name, 'Bill the Cat'
  #   assert_equal order(:testorder1).card_num, '0000000000000000'
  # end

  test "if no order ID is stored in the session, update should not alter the record and should redirect to the index with an error method" do
    session[:order] = nil
    get :update, {order: {name: 'Bill the Cat', address: 'Bloom Boarding House', email: 'bill@thecat.com', city: 'Bloom County', state: 'NA', zip: '00000', card_name: "Berkeley Breathed", card_num: '0000000000000000', cvv: '111', billing_zip: '00000', expiry: Date.today.to_s}}
    assert_response :redirect
    assert_equal flash[:notice], "Sorry, your cart could not be found. Please try again."
    assert !orders(:testorder1).name
  end

end
