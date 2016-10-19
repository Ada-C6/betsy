require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create a merchant with no email, name or uid" do
    merchant = Merchant.new
    assert_not merchant.valid?
  end

  # test "the provider must be from github" do
  #   git_hash = {user_name: "kitty", email: "abc@aol.com", uid: 15, provider: "twitter"}
  #   merchant = Merchant.build_from_github(git_hash)
  #   assert_not merchant.valid?
  #
  # end

end
