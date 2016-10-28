require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "create a new order with valid input values" do
    assert products(:one).valid?
   end

  test "cannot create a order without a status" do
    order = Order.new(name: "Penny")
    assert_not order.valid?
  end

  test "cannot create a order without an incorrect status" do
    order = Order.new(status: "Penny")
    assert_not order.valid?
  end

  test "cannot change an order's status to an incorrect value" do
    order = orders(:one)
    order.status = "Penny"
    assert_not order.valid?
  end

  test "order should return correct number of products" do
    order = orders(:one)
    assert_respond_to(order, :products)

    assert_equal(order.products.length, 2)
  end

  # test "The open? method will return true if an order is 'pending' and 'false' if it is 'paid', 'cancelled', or 'complete'" do
  # end


  # REMOVED BECAUSE NO LONGER VALIDATING ORDER_ITEM
  # test "order cannot be created without an order item" do
  #   test_order = orders(:one)
  #   assert_respond_to(test_order, :order_items)
  #   test_order.order_items.each do | order |
  #     OrderItem.destroy(order.id)
  #   end
  #
  #   test_order.reload
  #   assert_not test_order.valid?
  # end

end
