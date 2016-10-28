require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @merchant = Merchant.create(username: "Merchant", email: "a@b.com")
    @merchant_two = Merchant.create(username: "Merchant TWO", email: "two@b.com")
    @order = orders(:order_one)#Order.create(name: "Allison", email: "a@b.com")
    @order_two = orders(:order_five)
    @product = Product.create(name: "Product", price: 1234, merchant_id: @merchant.id, stock: 4)
    @order_item = OrderItem.create(quantity: 2, order_id: @order.id, product_id: @product.id)
    session[:order_id] = @order.id
    session[:ship_order_id] = @order_two.id
    session[:merchant_id] = @merchant.id
  end

  test "should show order" do
    get :show, id: @order.id
    assert_response :success
  end

  test "should show merchant_view to correct merchant" do
    get :merchant_view, :merchant_id => session[:merchant_id], id: @order.id
    assert_template :merchant_view
  end

  test "won't show merchant view to an invalid merchant" do
    session[:merchant_id] = @merchant_two.id
    get :merchant_view, :merchant_id => session[:merchant_id], id: @order.id
    assert_template :view_error
  end

  test "should get edit" do
    get :edit, id: @order.id
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order_two, order: {name: "Allison", cc_number: "123456789"}

    assert_redirected_to confirmation_path
  end

  test "#purchase should render the correct view" do
    get :purchase, id: @order
    assert_template :purchase
  end

  test "#purchase clears the cart" do
    get :purchase, id: @order
    assert_equal session[:order_id], nil
  end

  test "#ship redirects to the correct path" do
    patch :ship, id: session[:ship_order_id]
    assert_redirected_to merchant_path(session[:merchant_id])
  end
end
