require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "credit card number must be present and be 4 characters long" do
    order2 = Order.new(cc_number: 34, cc_exp_year: 1990, cc_exp_month: 7)
    order3 = Order.new(cc_number: 6789234, cc_exp_year: 1990, cc_exp_month: 7)

    assert orders(:valid_order).valid?
    assert_not order2.valid?
    assert_not order3.valid?
  end

  test "credit card should not have an expired date" do
    expired_year = Order.new(cc_number: 1234, cc_exp_year: (Time.now.year - 2), cc_exp_month: 12)
    expired_month_in_current_year = Order.new(cc_number: 1234, cc_exp_year: Time.now.year, cc_exp_month: (Time.now.month - 2))

    assert_not expired_year.valid?
    assert_not expired_month_in_current_year.valid?
  end

  test "an order model object's status defaults to PENDING upon being saved to the database" do
      o = orders(:valid_order)
      o.save
      assert_equal("PENDING", o.status)
  end

  test "confirming the private method update_total occurs on an order object" do
      p = Order.new
      assert_equal(0, p.total)

      o = orders(:valid_order)
      assert_equal(4936, o.total)

    #   assert_difference("o.order_items = order_items(:four_unit)", 0) do
    #       o.save
    #   end
  end

end

# test
# create order model object
# add order items to it (fixtures)
#
# assert_difference
# end
