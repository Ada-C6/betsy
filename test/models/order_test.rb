require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "An order builds itself with a status of pending" do
      new_order = Order.build_order

      assert_equal new_order.order_status, "pending"

  end

  test "Create an Order with valid data" do
    order = orders(:one)
    assert order.valid?
  end

  test "Order must have a status of pending, paid, or cancelled" do
    order1 = orders(:one)
    order2 = orders(:two)
    order3 = orders(:three)
    # order4 = Order.new(order_status: "I have no valid status")
    order5 = Order.new
    order6 = orders(:three)


    assert order1.valid?
    assert order2.valid?
    assert order3.valid?
    # assert_not order4.valid?
    assert_not order5.valid?
    assert order6.valid?
    #
    # assert_includes order4.errors, :order_status
    assert_includes order5.errors, :order_status
  end

  test "Can mark itself as paid" do
    order = orders(:one)
    assert_equal order.order_status, "pending"
    order.mark_order_paid
    assert_equal order.order_status, "paid"
  end

  test "Can set status to cancelled" do
    order = orders(:one)
    assert_equal order.order_status, "pending"
    order.cancel_order
    assert_equal order.order_status, "cancelled"
  end

  test "Can set status to complete" do
    order = orders(:one)
    assert_equal order.order_status, "pending"
    order.complete_order
    assert_equal order.order_status, "completed"
  end

  test "Purchasing an order decreases the stock ofeach product in the order" do

    product1 = products(:product_stock1)
    product2 = products(:product_stock2)

    beginning_stock1 = product1.quantity
    beginning_stock2 = product2.quantity

    quantity_change1 =order_items(:reduce_quantity1).quantity
    quantity_change2 =order_items(:reduce_quantity2).quantity

    orders(:purchasing_order).decrease_products_stock

    ending_stock1 = product1.reload.quantity
    ending_stock2 = product2.reload.quantity

    assert_equal(ending_stock1, beginning_stock1 -quantity_change1)
    assert_equal(ending_stock2, beginning_stock2 -quantity_change2)

  end

  test "Cancelling an order (after purchasing)increases the stock of each product in the order"do

    product1 = products(:product_stock1)
    product2 = products(:product_stock2)

    beginning_stock1 = product1.quantity
    beginning_stock2 = product2.quantity

    quantity_change1 =order_items(:reduce_quantity1).quantity
    quantity_change2 =order_items(:reduce_quantity2).quantity

    orders(:purchasing_order).increase_products_stock

    ending_stock1 = product1.reload.quantity
    ending_stock2 = product2.reload.quantity

    assert_equal(ending_stock1, beginning_stock1 +quantity_change1)
    assert_equal(ending_stock2, beginning_stock2 +quantity_change2)

  end

  test "When an order item is associate with an order, the order is not marked as complete until all the order items have shipped" do

    order = orders(:order_to_be_shipped)
    item1 = order_items(:not_shipped_item1)
    item2 = order_items(:not_shipped_item2)

    assert_equal order.order_status, "paid"

    order.complete_order

    assert_equal order.order_status, "paid"


    item1.shipped = true
    item1.save
    item1.reload

    order.reload

    order.complete_order
    assert_equal order.order_status, "paid"

    item2.shipped = true
    item2.save
    item2.reload

    order.reload

    order.complete_order
    order.reload
    assert_equal order.order_status, "completed"

  end
end
