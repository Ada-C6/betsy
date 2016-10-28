require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create a merchant with no email, name or uid" do
    merchant = Merchant.new
    assert_not merchant.valid?
  end

  test "the Merchant will not be valid without an email" do
    git_hash = {uid: 15, provider: "twitter",
      info: {nickname: 'kitty'}}
    merchant = Merchant.build_from_github(git_hash)
    assert_not merchant.valid?

  end
end
