require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase
  setup do
    @order_item = OrderItem.create(quantity: 2, product_id: 1, order_id: 1)
    @another_order_item = OrderItem.create(quantity: 1, product_id: 2, order_id: 1)
    @order = Order.create(name: "Allison",  email: "a@b.com")
    @product = Product.create(name: "product", price: 1234, stock: 20)
  end

  test "should be able to create a new order item" do
    @cart = Order.create(name: "name", email: "email@email.com")
    post :create, :product_id => @product.id, order_item: {quantity: 2}
    assert_response :redirect
    assert_redirected_to order_path
  end

  test "Newly created order items should have the right fields" do
    post :create, :product_id => @product.id, order_item: {quantity: 3}

    item = OrderItem.find_by(quantity: 3)
    sample_item = OrderItem.new(quantity: 3, product_id: @product.id)

    assert_equal item.quantity, sample_item.quantity
    assert_equal item.product_id, sample_item.product_id
  end

  test "creating a new item should change the total number of items" do
    assert_difference('OrderItem.count', 1) do
      post :create, :product_id => @product.id, order_item: {quantity: 3}
    end
  end

  test "trying to add a quantity greater than the stock will not work" do
    assert_no_difference('OrderItem.count') do
      post :create, :product_id => @product.id, order_item: {quantity: 200}
    end
  end

  test "trying to add a quantity greater than the stock will render the correct page" do
    post :create, :product_id => @product.id, order_item: {quantity: 200}

    assert_template :not_enough_stock
  end

  test "if an item already exists in the cart, don't create a new order item, just add to current cart item's quantity" do
    post :create, :product_id => @product.id, order_item: {quantity: 3}
    assert_no_difference('OrderItem.count') do
      post :create, :product_id => @product.id, order_item: {quantity: 7}
    end

    assert_not_nil OrderItem.where(product_id: @product.id, quantity: 10).first
  end

  test "renders correct template if create fails to save" do
    post :create, :product_id => @product.id, order_item: {quantity: -3}

    assert_template :failed_order_update
  end

  test "should update order_item" do
    patch :update, id: @order_item, order_item: {quantity: 4}

    assert_response :redirect
    assert_redirected_to order_path
  end

  test "should render correct template if order_item quantity update fails to save" do
    patch :update, id: @order_item, order_item: {quantity: -123}

    assert_template :failed_order_update
  end

  test "should destroy order_item" do
    assert_difference('OrderItem.count', -1) do
      delete :destroy, id: @another_order_item
    end

    assert_redirected_to order_path
  end
end
