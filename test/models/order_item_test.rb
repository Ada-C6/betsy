require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "create a new product with valid data" do
    assert order_items(:one).valid?
    assert order_items(:two_true).valid?
  end

  test "Should reject an OrderItem with no quantity" do
    item = OrderItem.new(product_id: products(:one).id, order_id: orders(:two).id)
    assert_not item.valid?
  end

  test "Should reject an OrderItem with a quantity other than an integer" do
    order_item = OrderItem.new(product_id: products(:two).id, order_id: orders(:two).id, quantity: "a")
    order_item2 = OrderItem.new(product_id: products(:one).id, order_id: orders(:two).id, quantity: false)
    assert_not order_item.valid?
    assert_not order_item2.valid?
  end

  test "Must belong to a product AND order" do
    item = OrderItem.new(product_id: products(:one).id, order_id: orders(:two).id, quantity: 1)
    assert item.valid?
    item_two = OrderItem.new(product_id: 1, order_id: orders(:two), quantity: 1)
    item_three = OrderItem.new(product_id: products(:one).id, order_id: 1, quantity: 1)
    assert_not item_two.valid?
    assert_not item_three.valid?
  end

  test "Should reject an OrderItem with a quantity less than or equal to 0" do
    order_item = OrderItem.new(product_id: products(:two), order_id: orders(:two), quantity: -1)
    order_item2 = OrderItem.new(product_id: products(:one), order_id: orders(:two), quantity: 0)
    assert_not order_item.valid?
    assert_not order_item2.valid?
  end
end
