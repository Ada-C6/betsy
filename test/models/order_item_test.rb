require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase

  test "Create a valid orderitem" do
    assert order_items(:one).valid?
  end
end
