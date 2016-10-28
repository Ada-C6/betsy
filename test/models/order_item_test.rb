require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  def setup
    @product = Product.create(name: "cat", price: 1234, stock: 14)
    @item = OrderItem.create(quantity: 1, product_id: @product.id, order_id: 1)
  end

  test "Create an OrderItem with all valid data" do
    item = order_items(:item_one)

    assert item.save
    assert item.valid?
  end

  test "Cannot create an order item with no quantity" do
    item = OrderItem.new(product_id: 1, order_id: 1)

    assert_not item.save
    assert_not item.valid?
    assert item.errors.keys.include?(:quantity), "quantity is not in the errors hash"
  end

  test "Cannot create an order item with quantity less than 1" do
    item = OrderItem.new(quantity: 0, product_id: 1, order_id: 1)
    another_item = OrderItem.new(quantity: -4, product_id: 1, order_id: 1)

    assert_not item.save
    assert_not item.valid?
    assert item.errors.keys.include?(:quantity), "quantity is not in the errors hash"

    assert_not another_item.save
    assert_not another_item.valid?
    assert another_item.errors.keys.include?(:quantity), "quantity is not in the errors hash"
  end

  test "#find product returns the correct product" do
    assert_equal @item.find_product.name, "cat", "Did not return the correct product"
  end
end
