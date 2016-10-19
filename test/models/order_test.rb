require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "can create an order with valid data" do
    order = Order.new(name: "Igor Smith", email: "xkcd@gmail.com", street_address: "38 Main St",
    city: "Seattle", state: "WA", mailing_zip: "98102", cc_number: "1223456743254456", cc_exp_month: 5,
    cc_exp_year: 2017, cc_sec_code: 328, billing_zip: "98102")
    assert order.valid?
  end

  test "cannot create an order with a non-numerical zip code" do
    order = Order.new(name: "Igor Smith", email: "xkcd@gmail.com", street_address: "38 Main St",
    city: "Seattle", state: "WA", mailing_zip: "hwgow", cc_number: "abcd456743254456", cc_exp_month: 5,
    cc_exp_year: 2017, cc_sec_code: "abd", billing_zip: "hha02")
    assert_not order.valid?
    assert_includes order.errors, :mailing_zip
    assert_includes order.errors, :cc_number
    assert_includes order.errors, :cc_sec_code
    assert_includes order.errors, :billing_zip
  end

  test "cannot create two orders with the same name and street address" do
    order1 = orders(:nicole)
    order2 = Order.new(name: "Nicole", email: "xkcd@gmail.com", street_address: "12 Main St",
    city: "Seattle", state: "WA", mailing_zip: "98102", cc_number: "1223456743254456", cc_exp_month: 5,
    cc_exp_year: 2017, cc_sec_code: 328, billing_zip: "98102")
    assert_not order2.valid?
    assert_includes order2.errors, :name
  end

  test "can create two orders with different street addresses" do
    order1 = orders(:nicole)
    order2 = Order.new(name: "Nicole", email: "xkcd@gmail.com", street_address: "68 Main St",
    city: "Seattle", state: "WA", mailing_zip: "98102", cc_number: "1223456743254456", cc_exp_month: 5,
    cc_exp_year: 2017, cc_sec_code: 328, billing_zip: "98102")
    assert order2.valid?
  end

  test "cannot create an order with missing information" do
    order = Order.new
    assert_not order.valid?
    assert_includes order.errors, :name
    assert_includes order.errors, :email
    assert_includes order.errors, :street_address
    assert_includes order.errors, :city
    assert_includes order.errors, :state
    assert_includes order.errors, :mailing_zip
    assert_includes order.errors, :cc_number
    assert_includes order.errors, :cc_exp_month
    assert_includes order.errors, :cc_exp_year
    assert_includes order.errors, :cc_sec_code
    assert_includes order.errors, :billing_zip
  end

  test "zip code must be 5 digits long" do

  end

  test "zip code cannot be longer or shorter than 5 digits" do

  end

  test "email address must be in a valid format" do
    order = Order.new(name: "Igor Smith", email: "xkcd@gmail.com", street_address: "38 Main St",
    city: "Seattle", state: "WA", mailing_zip: "98102", cc_number: "1223456743254456", cc_exp_month: 5,
    cc_exp_year: 2017, cc_sec_code: 328, billing_zip: "98102")
    assert order.valid?
  end

  test "email address cannot be in an invalid format" do
    order = Order.new(name: "Igor Smith", email: "xkcdgmail.com", street_address: "38 Main St",
    city: "Seattle", state: "WA", mailing_zip: "98102", cc_number: "1223456743254456", cc_exp_month: 5,
    cc_exp_year: 2017, cc_sec_code: 328, billing_zip: "98102")
    assert_not order.valid?
    assert_includes order.errors, :email
  end

  # In a world where we could only accept valid credit cards, we would use the Luhn
  # algorithm here. In this world, AmEx is 15 and the rest are 16 digits long, so that's
  # what we're testing
  test "credit card number must be 15 to 16 digits long" do

  end

  test "credit card number cannot be invalid" do

  end

  # The security code for AmEx is 4 digits, whereas other cards are only 3
  test "credit card security number must be 3 to 4 digits long" do

  end

  # AmEx is 15 digits with 4-digit security, whereas other cards are 16 digits with 3-digit security
  test "credit card number.length plus security number.length must total 19" do

  end
end
