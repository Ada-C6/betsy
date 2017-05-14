require 'test_helper'

class TransactionsControllerTest < ActionController::TestCase
  test "you can see check out page if you have items in your cart" do
    session[:cart_id]=cart_products(:test_cart_item).cart.id
    get :new
    assert_response :success
  end

  test "if you have no items in your cart you are redirected" do
    request.env["HTTP_REFERER"]="blah"
    session[:cart_id]=333
    get :new
    assert_equal flash[:notice], "You have no items to checkout!"
    assert_redirected_to "blah"
  end

  test "you can create a transaction (check out)" do
    session[:cart_id]=cart_products(:test_cart_item).cart.id
    transaction_params={transaction: {client_name: "Quai", client_email: "qlw@me.com", client_address: "123 My Place Ln. , Seattle WA, 23293", client_cc_num: "1213123121232", client_exp: "01/23"}}
    post :create, transaction_params
    assert_response :success
  end

  test "you can see an individual order" do
    get :show, id: transactions(:one)
    assert_response :success
  end

  test "I can see my orders when I am logged in as a merchant" do
    session[:user_id]= users(:current_user).id
    get :show_all
    assert_response :success
  end

  test "I can't see my orders when I'm not logged in" do
    get :show_all
    assert_response :success
    assert_equal assigns(:my_tps), nil #why isn't this []...
  end

  test "I can mark an item as shipped" do
    request.env["HTTP_REFERER"]="blah"
    patch :mark_shipped, id: transaction_products(:one)
    assert_redirected_to "blah"
  end

   #only the person who owns it should be able to mark it shipped
   #no permissions currently exist

  test "I can unmark an item as shipped" do
    request.env["HTTP_REFERER"]="blah"
    patch :mark_not_shipped, id: transaction_products(:one)
    assert_redirected_to "blah"
  end

end
