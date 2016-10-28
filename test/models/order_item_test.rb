require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "Cannot create OrderItem without an Order association" do
    order_item = OrderItem.new(quantity: 3, product_id: 22)

    assert_not order_item.valid?
  end

  test "Cannot create OrderItem without a Product association" do
    order_item = OrderItem.new(quantity: 3, order_id: 2)

    assert_raise(NoMethodError) { order_item.valid? } # when no product is present, #must_have_enough_stock method cannot call product.inventory; fails with NoMethodError
  end

  test "Cannote create an OrderItem without a quantity that is: integer greater than 0" do
    # No quantity fails
    order_item_one = OrderItem.new(product_id: 1, order_id: 2)
    assert_not order_item_one.valid?

    # Float quantity fails
    order_item_one = OrderItem.new(product_id: 1, order_id: 2, quantity: 3.3)
    assert_not order_item_one.valid?

    # Quantity 0 fails
    order_item_one = OrderItem.new(product_id: 1, order_id: 2, quantity: 0)
    assert_not order_item_one.valid?
  end

  test "Can create an OrderItem with valid data, it has correct associations" do
    order_item = OrderItem.new(product_id: 1, order_id: 2, quantity: 3)

    assert order_item.valid?

    order_item.save

    assert_equal order_item.product.id, 1
    assert_instance_of Product, order_item.product

    assert_equal order_item.order.id, 2
    assert_instance_of Order, order_item.order
  end

  test "#subtotal method correctly calculates subtotal" do
    order_item = order_items(:three)
    # quantity: 15
    # product_id: 1
    # price: 999999

    assert_equal 14999985, order_item.subtotal
  end

  test "#must_have_enough_stock method should add to errors hash if insufficient_stock" do
    order_item = order_items(:three)

    order_item.must_have_enough_stock

    assert_includes order_item.errors, :stock
  end
  
  # @TODO - remove this test if #sufficient_stock? method remains unused
  # test "#sufficient_stock? method should return false for inventory < quantity" do
  #   order_item = order_items(:three)
  #
  #   assert_equal false, order_item.sufficient_stock?
  # end

  # @TODO - remove this test if #sufficient_stock? method remains unused
  # test "#sufficient_stock? method should return true for inventory = quantity" do
  #   order_item = order_items(:three)
  #   order_item.update(quantity: 10)
  #
  #   assert_equal true, order_item.sufficient_stock?
  # end
end
