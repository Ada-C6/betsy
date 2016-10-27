require 'test_helper'

class ProductTest < ActiveSupport::TestCase
# rake test TEST=test/models/order_item_test.rb

# Testing Checklist:
  # start with validations
  # Check custom methods in the model (dont do private)
  # relatonships

# let's pass an easy test!
  test "the truth" do
    assert true
  end

  test "valid product" do
    assert create(:product).valid?
  end
##### testing product validations #####

  # This test passes b/c of added validations.
  test "Products must have a name, otherwise invalid." do
    product = build(:product, name: nil)
    assert product.invalid?
  end

  # test "Adding a name to a product that wasn't valid because it lacked name. Will become valid, once assigned one" do
  #   product = create(:product, category: "fashion", name: nil)
  #   product.name = "Name Acquired"
  #   product.save
  #   assert(product.valid?)
  # end

  # test "If a name is removed from product, product will then become invalid " do
  #   product = create(:product)
  #   assert(product.valid?)
  #
  #   product.name = nil
  #   assert_not(product.valid?)
  # end

  test "Products must have a price, otherwise invalid" do
    product = build(:product, price: nil)
    refute product.valid?
    assert_not_nil product.errors[:price], "no validation error for the price present. "
  end
# #
  test "product prices should not be a negative number" do
    product = build(:product, price: -1 )
    assert product.invalid?
  end

  test "product prices should be greater than zero" do
    product = build(:product, price: 0 )
    assert product.invalid?
  end

  test "product prices should be a postive number. 1.00 is valid" do
    product = build(:product, price: 1.00 )
    assert product.valid?
  end

# Commented out because to make validations for this one might caught merge conflicts.
  # test "Product prices must be decimals. 2 will be invalid." do
  #   product = build(:product, price: 2)
  #   assert product.invalid?
  # end

##### testing product associations #####
  test "Products with a valid category will be valid. Valid only if category one of the following: minions, home decor, fashion, & personal care." do
    product = create(:product, category: "fashion")
    assert_not product.invalid?
  end

# not necessarily passing because we haven't written proper validations. We'd need to for it to pass. Partly this is logically taken care of because we only allow category to be determined via a drop down menu.
  test "Products outside of valid category will be invalid." do
    product = create(:product, category: "other")
    assert product.invalid?
  end

  test "A product must belong to a user. " do
    product = build(:product, user: nil)
    product.invalid?
  end

  test "Products must have correct category, product is expected to be fashion." do
    # default category: fashion /from factory.
    product = build(:product)
    fashion = build(:product)

    assert_equal(product.category, fashion.category)
  end

end
