require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create a merchant with no email or uid" do
    merchant = Merchant.new
    assert_not merchant.valid?
  end

end
