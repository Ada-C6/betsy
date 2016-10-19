require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "Create a valid merchant" do
    assert merchants(:snoopy).valid?
  end

  test "Create a merchant with no username and/or no email" do
    m1 = Merchant.new
    m2 = Merchant.new
    m2.username = "Scooby"
    m3 = Merchant.new
    m3.email = "scooby@gmail.com"
    assert_not m1.valid?
    assert_not m2.valid?
    assert_not m3.valid?
  end

  test "Should not create a merchant with the same username or email as another" do
    Merchant.create!(username: "foo", email: "foo@hotmail.com")
    m2 = Merchant.new(username: "foo", email: "other@hotmail.com")
    m3 = Merchant.new(username: "other", email: "foo@hotmail.com")
    assert_not m2.valid?
    assert_not m3.valid?
  end

end
