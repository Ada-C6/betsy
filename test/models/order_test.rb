require 'test_helper'

class OrderTest < ActiveSupport::TestCase
# rake test TEST=test/models/order_ test.rb

# Testing Checklist:
  # start with validations
  # Check custom methods in the model (dont do private)
  # relatonships

# let's pass an easy test!
  test "the truth" do
    assert true
  end
##### test relationship with user #####

  test "Valid order" do
    order = create(:order)
    assert order.valid?
  end

  test "orders must belong to a user" do
    order = build(:order, user: nil)
    refute order.invalid?
    assert_not_nil order.errors[:user], "orders must belong to a user!"
  end


  test "orders should have correct user" do
    order = create(:order)
    user = create(:user)
    assert_equal(order.name, user.name)
  end
# ATTEMPTING to test this METHOD from ORDERS MODEL:
    # def total_price
    #   return self.order_items.inject(0) {|sum, order_item | sum + order_item.total_price }
    # end
  # not properly being created.
  # test "To ensure that when 2 products ($10.00 each) will have a total_price = $20.00" do
  #   order1 = create(:order)
  #   order2 = create(:order)
  #   total = order1.find_by(product_id.price)+ order2(product_id.price)
  #   assert_equal (total, 20.00)
  #   a = create(:order_with_2_products)
  #
  # end

#@ maya, you might need to look at these two:
  # test "Order status will only be valid if they are any of the following: completed, canceled, ____,____ ." do
  #   order = create(:order, status: "something wonky")
  #
  #   assert order.valid?
  # end

  # test "Order status will not be valid if its not any of the following: ___, ___, ___" do
  #   order = create(:order, status: "something wonky")
  #
  #   assert order.invalid?
  # end

# *email* will we make this necessary?
# also might be able to add this to a hash in factory so you can be certain to test all cases.
# additionally you can test the postive case of things.
  test "If you're trying to submit an order, you must have: status, name, *email*, street_address, city, state, zip, phone" do
    submit_order = (:order, status: nil, name:nil, *email: nil, city: nil, zip:nil, phone: nil)
    assert submit_order.invalid?
  end

  test "Payment parameters are valid as long as you have @ least 4 numbers in cc_number" do
    order = create(:order, cc_number: 3333)
    assert order.valid?
  end

  test "Payment parameters are valid as long as you have @ least 4 numbers in cc_number. If you have less, it will be invalid" do
    order = create(:order, cc_number: 333)
    assert order.invalid?
  end

  test "Make sure phone number user enters is the correct amount (8 nums long?)" do

  end

  test "CVC should be at least 3 numbers but not exceed 4 (as american express has 4).Thus, 1234 should be valid" do
    order = create(:order, cvc: 1234)
    assert order.valid?
  end

  test "CVC should be at least 3 numbers but not exceed 4 (as american express has 4). Thus, 12345 will be invalid" do
    order = create(:order, cvc: 12345)
    assert order.invalid?
  end


  test "Order exp_month can only be 01 through 12, only valid if they represent the 12 month calendar year.So, 01 will be valid" do
    order = create(:order, exp_month: 01)
    assert order.valid?
  end

  test "Order exp_month can only be 01 through 12, only valid if they represen the 12 month calendar year. 13 will be invalid" do

  end

  test "Orders that have a credit card that expires before the time of purchase. Will be invalid & possibly display a error message. Exp_Month: 12, Exp_Year:12, will be invalid " do
    order = create(:order, exp_month:12, exp_year:12)
    assert order.invalid?
  end


  test "Orders that have credit card number 12/20 expiration will be valid because its hasn't expired yet." do
    order = create(:order, exp_month:12, exp_year:20)
    assert order.valid?

  end


  
  # belongs_to :product
  # belongs_to :user
  # has_many :order_items



  # t.string   "status",         limit: 80
  # t.string   "name"
  # t.string   "email"
  # t.string   "street_address"
  # t.string   "city"
  # t.string   "state"
  # t.integer  "zip"
  # t.integer  "phone",          limit: 10
  # t.integer  "user_id"
  # t.integer  "product_id"
  # t.integer  "cc_number"
  # t.integer  "exp_month"
  # t.integer  "exp_year"
  # t.integer  "cvc"





end
