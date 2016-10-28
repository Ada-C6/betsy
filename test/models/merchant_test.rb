require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "paid orders calculate as paid" do
    assert_equal 500, merchants(:one).revenue_paid_orders
  end

  test "pending orders calculate correctly" do
    assert_equal 600, merchants(:one).revenue_pending_orders
  end

  test "completed orders calculate correctly" do
    assert_equal 300, merchants(:one).revenue_completed_orders
  end

  test "cancelled orders calculate correctly" do
    assert_equal 300, merchants(:one).revenue_cancelled_orders
  end

  test "total orders calculate correctly" do
    assert_equal 1400, merchants(:one).total_revenue
  end

  test "correct number of pending orders" do
    assert_equal 2, merchants(:one).pending_orders
  end

  test "correct number of cancelled orders" do
    assert_equal 1, merchants(:one).cancelled_orders
  end

  test "correct number of paid orders" do
    assert_equal 2, merchants(:one).paid_orders
  end

  test "correct number of completed orders" do
    assert_equal 1, merchants(:one).completed_orders
  end

  test "correct number of orders" do
    assert_equal 5, merchants(:one).total_orders
  end

end
