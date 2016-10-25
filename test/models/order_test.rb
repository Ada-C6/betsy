require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
########### test relationship with user #########

  test "orders must belong to a user" do
    order = build(:order, user: nil)
    refute order.valid?
    assert_not_nil order.errors[:user], "orders must belong to a user!"
  end

  test "orders should have correct user" do
    order = create(:order)
    user = create(:user)

    assert_equal(order, user)
  end


end
