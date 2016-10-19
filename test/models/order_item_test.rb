require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase

  test "Create a valid orderitem" do
    assert order_items(:one).valid?
  end

  test "Create a merchant with no quantity" do
    o = OrderItem.new
    o.product_id = 1
    o.order_id = 1
    assert_not o.valid?

    o.quantity = 0
    assert_not o.valid?

    o.quantity = 1
    assert o.valid?

    o.quantity = "hi"
    assert_not o.valid?
  end

end
