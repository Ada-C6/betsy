require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

########### test relationship with user #########


  test 'orders must belong to a user' do
    assert(orders(:normal_order).valid?)
    assert_not(orders(:order_without_user).valid?)
  end

  test 'orders should have the correct user' do
    order = orders(:normal_order)
    user = users(:normal_user)

    assert_equal(order.user_id, user.id)
  end

  ########### test relationship with OrderProducts #########

  test 'orders have many OrderProducts' do
    order = orders(:order_with_order_products)
    assert_not_empty(order.order_products)
  end

  test 'orders have the correct OrderProducts' do
    order = orders(:order_with_order_products)
    assert(order.order_products.include?(order_products(:one)))
    assert(order.order_products.include?(order_products(:two)))
  end

  ############### test custom model methods #########

  test 'when called on an order, subtotal totals up the order' do
    order = orders(:order_with_order_products)
    assert_equal(order.subtotal, 5000)
  end

  test 'when called on anything not an order, subtotal returns 0 ??? ' do
    order = orders(:order_without_order_products)
    assert_equal(order.subtotal, 0)
    assert_not_nil(order.subtotal)
  end

  test 'subtotal returns an integer' do
    order = orders(:order_with_order_products)
    assert_instance_of(Fixnum, order.subtotal)
    # originally wrote Integer here. how do we know when to use Fixnum vs. Integer? fuzzy to me, esp since this is a database object?
  end

  test 'when an order contains non-valid orderproducts, the subtotal does not include those' do
    order = orders(:order_with_invalid_ops)
    assert(order.order_products[0].valid?)
    assert_not(order.order_products[1].valid?)
    assert_equal(order.subtotal, 4000)
  end
end
