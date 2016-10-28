require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
#rake test TEST=test/models/order_item_test.rb

# Testing Checklist:
# start with validations
# Check custom methods in the model (dont do private)
# relatonships

# let's pass an easy test!
  test "the truth" do
    assert true
  end

# NEED TO BUILD FACTORY TRISH
  # test "valid order_item" do
  #   assert create(:order_item).valid?
  # end

  ##### testing product validations #####
  test "order_item must have a unit price, otherwise invalid." do
    order_item = build(:order_item, unit_price: nil)
    assert order_item.invalid?
  end

  test "order_item must have a quantity, otherwise invalid." do
    order_item = build(:order_item, name: nil)
    assert order_item.invalid?
  end
  # test "order_items cannot be used when product_id - stock is below zero." do
  #   order_items = build(:order_items, )
  #   assert order_items.invalid?
  # end

  test "order_item prices should not be a negative number" do
    order_item = build(:order_item, unit_price: -1 )
    assert_not order_item.invalid?
  end

  test "An order_item price cannot be zero" do
    order_item = build(:order_item, unit_price: 0 )
    assert order_item.invalid?
  end

  test "An order_item with all fields filled out will be vaild. " do
    order_item = build(:order_item)
    assert order_item.valid?
  end

  test "order_item unit price must be in decimals. '2' will be invalid." do
    order_item = build(:order_item, unit_price: 2)
    assert order_item.invalid?
  end

  ##### testing product associations #####

  test "order_items must belong to user & an order. If they have both they will be valid" do
    order_item = build(:order_item)
    assert order_item.valid?
  end

  test "order_item must belong to user & an order. If they have neither association. They will be invalid. " do
    order_item = build(:order_item, user_id: nil, product_id: nil)
    assert order_item.invalid?
  end

  test "order_item must belong to the correct user. Expect order_item to belong to ____" do
    order_item = build(:order_item)
    assert order_item.invalid?
  end

  test "order_item must belong to a user" do
    order_item = build(:order_item)
    order_item2 = build(:order_item)

    assert_equal(order_item, order_item2)
  end
end
