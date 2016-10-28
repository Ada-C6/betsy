require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "A new merchant is built with the auth_hash from GitHub" do
    merchant = Merchant.build_from_github({ uid: "12345", "info" => { "nickname" => "kelly", "email" => "kelly@we.com" } })

    assert merchant.valid?
  end

  test "Create a Merchant with valid data" do
    merchant = merchants(:one)
    assert merchant.valid?
  end

  test "Merchant must have an email, uid, and provider" do
    merchant = Merchant.new
    assert_not merchant.valid?

    assert_includes merchant.errors, :email
    assert_includes merchant.errors, :uid
    assert_includes merchant.errors, :provider
  end

  test "get_merchant_orders will return a collection of all order items associated with that merchant" do
    merchant = merchants(:merchant_with_orders)

    orders = merchant.get_merchant_orders
    assert_kind_of  OrderItem::ActiveRecord_Relation, orders
    assert_includes orders, order_items(:reduce_quantity1)
    assert_includes orders, order_items(:reduce_quantity2)

  end

  test "get_merchant_orders can be used to filter order collections by order status" do
    merchant = merchants(:merchant_with_orders)

    orders = merchant.get_merchant_orders
    total_orders = orders.count

    paid_orders = merchant.get_merchant_orders("paid")

    pending_orders = merchant.get_merchant_orders("pending")

    completed_orders = merchant.get_merchant_orders("complete")

    cancelled_orders = merchant.get_merchant_orders("cancelled")

    assert_equal total_orders, paid_orders.count + pending_orders.count + completed_orders.count + cancelled_orders.count
  end

  test "get_merchant_orders considers a completed order (to the merchant) one that has been shipped, regardless of buyer order_status" do
    merchant = merchants(:filter_merchant)


    completed_orders = merchant.get_merchant_orders("completed")

    assert_includes completed_orders, order_items(:filter_complete_shipped)
    assert_includes completed_orders, order_items(:filter_paid_shipped)

    # An order shouldn't be able to be marked as complete if order items haven't shipped, but testing for it anyway.

    assert_not_includes completed_orders, order_items(:filter_complete_not_shipped)

  end

end
