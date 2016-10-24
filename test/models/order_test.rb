require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "credit card number must be present and be 4 characters long" do
    order2 = Order.new(cc_number: 34, cc_exp_year: 1990, cc_exp_month: 7, status: "PENDING")
    order3 = Order.new(cc_number: 6789234, cc_exp_year: 1990, cc_exp_month: 7, status: "PENDING")

    assert orders(:valid_order).valid?
    assert_not order2.valid?
    assert_not order3.valid?
  end

  test "credit card should not have an expired date" do
    expired_year = Order.new(cc_number: 1234, cc_exp_year: (Time.now.year - 2), cc_exp_month: 12, status: "PENDING")
    expired_month_in_current_year = Order.new(cc_number: 1234, cc_exp_year: Time.now.year, cc_exp_month: (Time.now.month - 2), status: "PENDING")

    assert_not expired_year.valid?
    assert_not expired_month_in_current_year.valid?
  end

  test "an order model object's status is nil upon initiation, then set to PENDING due to the set_order_status private method in the model" do
      order = Order.new(cc_number: 1231, cc_exp_year: 2016, cc_exp_month: 12)
      assert_equal(nil, order.status)

      order.save
      assert_equal("PENDING", order.status)
  end

  

end
