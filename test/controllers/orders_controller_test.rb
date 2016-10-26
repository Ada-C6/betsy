require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "destroy on a valid order (unpurchased cart) should result in the appropriate redirect" do
    session[:order] = orders(:testorder1).id
    delete :destroy

    assert session[:order] == nil
    assert_response :redirect
    assert_redirected_to carts_index_path
  end

  test "destroy on a valid order (unpurchased cart) should result in a decrement of number of orders in the database" do
    assert_difference('Order.count', -1) do
      session[:order] = orders(:testorder1).id
      delete :destroy
    end
  end

  test "destroy on a valid order (unpurchased cart) should remove that order from the database" do
    session[:order] = orders(:testorder1).id
    assert Order.all.include?(orders(:testorder1))
    delete :destroy
    assert !Order.all.include?(orders(:testorder1))
  end

  test "destroy on an invalid order should result in an error code" do
    session[:order] = -1
    delete :destroy
    assert_response :missing
  end

  test "destroy on an invalid order should not decrement the number of orders in the database" do
    assert_difference('Order.count', 0) do
      session[:order] = -1
      delete :destroy
    end
  end

end
