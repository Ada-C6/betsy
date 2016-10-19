require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "credit card must present and be 16 characters long" do
    order = Order.new(cc_number: 2345123454326789, cc_exp_year: 2016, cc_exp_month: 10)
    order2 = Order.new(cc_number: 1234, cc_exp_year: 1990, cc_exp_month: 7)
    order3 = Order.new(cc_number: 2345123454326789234, cc_exp_year: 1990, cc_exp_month: 7)

    assert order.valid?
    assert_not order2.valid?
    assert_not order3.valid?
  end

  test "credit card should not have an expired date" do
    order = Order.new(cc_exp_year: 2014, cc_exp_month: 12)
    order2 = Order.new(cc_exp_month: 10, cc_exp_year: 2013)
    order3 = Order.new(cc_exp_year: 2016, cc_exp_month: 9, cc_number: 2345123454326789)

    assert_not order.valid?
    assert_not order2.valid?
    #this assertion should not pass since month is in the past, month is not yet linked to year, working on it
    assert_not order3.valid?
  end
end
