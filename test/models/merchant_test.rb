require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "Create a valid merchant" do
    assert merchants(:snoopy).valid?
  end

  test "Cannot create a merchant with missing information" do
    merchant = Merchant.new
    assert_not merchant.valid?
    assert_includes merchant.errors, :username
    assert_includes merchant.errors, :email
  end

  test "Should not create a merchant with the same username or email as another" do
    Merchant.create!(username: "foo", email: "foo@hotmail.com")
    m2 = Merchant.new(username: "foo", email: "other@hotmail.com")
    m3 = Merchant.new(username: "other", email: "foo@hotmail.com")
    assert_not m2.valid?
    assert_not m3.valid?
  end

  test "can create a merchant from github" do
    auth_hash = OmniAuth.config.mock_auth[:github]
    user_gh_built = Merchant.build_from_github(auth_hash)

    assert user_gh_built.valid?
  end

end
