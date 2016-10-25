require 'test_helper'

class ProductTest < ActiveSupport::TestCase
# let's pass an easy test!
  test "the truth" do
    assert true
  end

#   test "valid product" do
#     assert create(:product).valid?
#   end
# ############## testing product validations #############
# ############## That haven't been written yet. #############
  test "Products must have a name, otherwise invalid." do
    product = build(:product, name: nil)
    refute product.valid? #'product is valid without name'
    assert_not_nil product.errors[:name], "no validation error for name present"

  end
#
  test "Adding a name to a product that wasn't valid because it lacked name. Will become valid, once assigned one" do
    product = create(:product, category: "fashion", name: nil)
    product.name = "Name Acquired"
    product.save
    assert(product.valid?)
  end
#
  test "If a name is removed from product, product will then become invalid " do
    product = create(:product)
    assert(product.valid?)

    product.name = nil
    assert_not(product.valid?)
  end
#
  test "Products must have a price, otherwise invalid" do
    product = build(:product, price: nil)
    refute product.valid?
    assert_not_nil product.errors[:price], "no validation error for the price present. "
  end
#
#   test "product prices should be greater than zero" do
#   end
#
#   test "Product prices must be decimals" do
#   end
############## testing product associations #############
  test "Products must have category" do
    assert(create(:product).valid?)
    assert_not(create(:product, category: nil).valid?)
  end

  test "Products must have correct category" do
    # default category: fashion /from factory.
    product = build(:product)
    fashion = build(:product)

    assert_equal(product.category, fashion.category)
  end




end
