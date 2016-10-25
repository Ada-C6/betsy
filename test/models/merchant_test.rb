require 'test_helper'

class MerchantTest < ActiveSupport::TestCase

  test "Created merchant must take name, email, uid, and provider" do
    merchant = Merchant.create!(name: "Aunt Betsy's", email: "auntie@betsy.to", uid: "qwert133557", provider: "betsoogle")
    assert merchant.valid?
  end

  test "Merchant is not valid when empty" do
    invalid_merchant = Merchant.new
    assert_not invalid_merchant.valid?
  end

  test "Merchant must have a name" do
    merchant = merchants(:one)
    merchant.name = nil
    assert_not merchant.valid?
  end

  test "Merchant must have an email" do
    merchant = merchants(:two)
    merchant.email = nil
    assert_not merchant.valid?
  end

  test "Merchant must have a uid" do
    merchant = merchants(:three)
    merchant.uid = nil
    assert_not merchant.valid?
  end

  test "Merchant must have a provider" do
    merchant = merchants(:four)
    merchant.provider = nil
    assert_not merchant.valid?
  end

  test "Merchants must be created with unique name and email, duplicates are not allowed" do
    valid_merchant = merchants(:three) # Might not need this, as :three should already be in database
    duplicate_merchant = Merchant.new(name: "Gingham Suppliers", email: "gingham@suppliers.ya", uid: "qwerty123456789", provider: "betsoogle")
    assert_not duplicate_merchant.save
  end

  test "Merchant cannot be saved if name is same as a different merchant" do
    # valid_merchant = merchants(:three)
    merchant = merchants(:three)
    merchant.name = "Ant's Blankets"
    assert_not merchant.save
  end

  test "Merchant cannot be saved if email is same as a different merchant" do
    # valid_merchant = merchants(:four)
    merchant = merchants(:four)
    merchant.email = "do@re.mi"
    assert_not merchant.save
  end

  test "Many merchants can be saved on the database, and be individually retrieved" do
    merchant = Merchant.new(name: "Aunt Betsy's", email: "auntie@betsy.to", uid: "qwert133557", provider: "betsoogle")
    merchant2 = Merchant.new(name: "Strawberries and Champagne", email: "little.shop@strawberries.fr", uid: "asdf12345", provider: "betsoogle")

    assert merchant.save
    assert merchant2.save
    assert_includes Merchant.all, merchant
    assert_includes Merchant.all, merchant2
  end

end
