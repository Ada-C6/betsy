require 'test_helper'

class MerchantTest < ActiveSupport::TestCase

  test "Create a merchant with all valid data" do
    merchant = Merchant.new(username: "Tiny Things", email: "tiny@things.com")
    assert merchant.valid?

    merchant = Merchant.new(username: "Tiny Things", email: "tiny@things.com")
    assert merchant.valid?

  end

  test "Cannot create a merchant with no username" do
    merchant = Merchant.new(email: "mysterymerchant@gmail.com")
    assert_not merchant.valid?
  end

  test "Cannot create a merchant with no email" do
    merchant = Merchant.new(username: "So Hard To Contact")
    assert_not merchant.valid?
  end

  test "Create two merchants with different usernames" do
    Merchant.create!(username: "Whoa Smalls", email: "whoasmalls@gmail.com")
    merchant2 = Merchant.new(username: "So Small", email: "sosmall@gmail.com")
    assert merchant2.valid?
  end

  test "Cannot create a merchant with an already existing username" do
    Merchant.create!(username: "TinyRUs", email: "tinyrus@gmail.com")
    merchant2 = Merchant.new(username: "TinyRUs", email: "differentemail@gmail.com")
    assert_not merchant2.valid?
  end

  test "Create two merchants with different email addresses" do
    Merchant.create!(username: "Wee Toys", email: "weetoys@gmail.com")
    merchant2 = Merchant.new(username: "Tiny Toys", email: "tinytoys@gmail.com")
    assert merchant2.valid?
  end

  test "Cannot create two merchants with the same email addresses" do
    Merchant.create!(username: "Wee Toys", email: "store@gmail.com")
    merchant2 = Merchant.new(username: "Tiny Toys", email: "store@gmail.com")
    assert_not merchant2.valid?
  end

  test "build_from_github does use github info to build a user" do
    auth_hash = OmniAuth.config.mock_auth[:github]
    test_merchant = Merchant.build_from_github(auth_hash)

    assert_equal test_merchant.username, auth_hash['info']['name']
    assert_equal test_merchant.email, auth_hash['info']['email']
  end

  test "build_from_github will use Github's nickname field if name is nil" do
    auth_hash = OmniAuth.config.mock_auth[:github2]
    test_merchant =Merchant.build_from_github(auth_hash)

    assert_equal test_merchant.username, auth_hash['info']['nickname']
    assert_equal test_merchant.email, auth_hash['info']['email']
  end

  test "find_all_order_items_revenue shows the merchant's total revenue" do
    merchant = merchants(:other_merchant)
    total_revenue = merchant.find_all_order_items_revenue

    assert_not_nil total_revenue
    assert_equal "$2962.95", total_revenue
  end

  test "find_all_order_items_revenue should return '0.00' if there's no products" do
    merchant = merchants(:merchant_without_products)
    total_revenue = merchant.find_all_order_items_revenue

    assert_equal "$0.00", total_revenue
  end

  test "find_all_order_items_revenue_by_status shows the merchant's total revenue by status" do
    merchant = merchants(:other_merchant)
    total_revenue = merchant.find_all_order_items_revenue_by_status

    assert_not_nil total_revenue
    assert_equal "$987.65", total_revenue[0]
    assert_equal "$987.65", total_revenue[1]
    assert_equal "$987.65", total_revenue[2]
  end

  test "find_all_order_items_revenue_by_status should return nil if there's no products" do
    merchant = merchants(:merchant_without_products)
    total_revenue = merchant.find_all_order_items_revenue_by_status

    assert_equal [nil, nil, nil, nil], total_revenue
  end

  test "find_total_number_of_orders_by_status shows the merchant's number of orders by status" do
    merchant = merchants(:other_merchant)
    total_orders = merchant.find_total_number_of_orders_by_status

    assert_not_nil total_orders
    assert_equal [1, 1, 1, 1, 1], total_orders
  end

  test "find_total_number_of_orders_by_status should return 0 if there's no products" do
    merchant = merchants(:merchant_without_products)
    total_orders = merchant.find_total_number_of_orders_by_status

    assert_equal [0, 0, 0, 0, 0], total_orders
  end
end
