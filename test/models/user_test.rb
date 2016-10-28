require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should be able to retrieve all orders associated with user" do
    lil = users(:lil).id
    user = User.find(lil)
    product = Product.find(99)
    item = OrderItem.find_by(order_id: 88)
    order = Order.find(88)
    assert_includes user.orders, order
  end

  test "should retrieve all revenues for the user" do
    lil = users(:lil).id
    user = User.find(lil)
    product = Product.find(99)
    item = OrderItem.find_by(order_id: 88)
    order = Order.find(88)
    assert_equal user.revenues, item.subtotal
  end

  test "shoudl retrieve revenues by status" do
    lil = users(:lil).id
    user = User.find(lil)
    assert_equal user.revenues_by_status("completed"), order_items(:lil).subtotal
  end

  test "should retrieve orders by status" do
    lil = users(:lil).id
    user = User.find(lil)
    assert_includes user.orders_by_status("completed"), Order.find(88)
    assert_not_includes user.orders_by_status("paid"), Order.find(88)
  end
end
