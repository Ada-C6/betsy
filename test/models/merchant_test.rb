require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "merchants with minimal information must be valid" do
    assert merchants(:merchant1).valid?
  end

  test "merchants without without email or username must be invalid" do
    #merchant3 has not username therefore should be invalid
    assert_equal false, merchants(:merchant3).valid?
    #adding username validates it
    merchants(:merchant3).username = "myname"
    assert merchants(:merchant3).valid?
    #removing email makes merchant invalid :(
    merchants(:merchant3).email = nil
    assert_not merchants(:merchant3).valid?
  end

  test "merchants should return their associated attributes" do
    assert_equal "bob1", merchants(:bob).username
    assert_equal "github", merchants(:bob).provider
    assert_equal "bob@bobness.com", merchants(:bob).email
  end

  test "merchants without a unique email are invalid" do
    merchant = Merchant.new(username:"merchant50", email: "bob@bobness.com")
    assert_equal "merchant50", merchant.username
    assert_equal false, merchant.valid?
  end

  test "merchants without a unique username are invalid" do
    merchant = Merchant.new(username:"bob1", email: "imaunicorn@github.com")
    assert_equal merchants(:bob).username, merchant.username
    assert_not merchant.valid?
  end

  test "Orders method should return a filtered array of orders belonging to merchant given allowable array of orders" do
    #:testorder1 and :goodorder are related to :bob merchant; method should only allow :goodorder to be listed in array.
    assert merchants(:bob).orders([orders(:goodorder)]), [orders(:goodorder)]
    assert_not merchants(:bob).orders([orders(:goodorder)]).include?(orders(:testorder1))
  end

  test "order_by_status method should return a filtered array of orders belonging to merchant given a status to filter for" do
    #:testorder1, :testorder2, and :pendingorder are related to :jane merchant; method should only allow :pendingorder to be listed in array.
    assert merchants(:jane).order_by_status("pending"), [orders(:pendingorder)]
    assert_not merchants(:jane).order_by_status("pending").include?(orders(:testorder1))
  end

end
