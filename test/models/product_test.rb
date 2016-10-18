require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "Create a valid product" do
    assert products(:snake).valid?
  end

  test "Cannot create an product with any missing information" do
    product = Product.new
    assert_not product.valid?
    assert_includes product.errors, :name
    assert_includes product.errors, :inventory
    assert_includes product.errors, :price
  end

  test "Should not create a product with invalid price" do
    p1 = Product.new(name: "prod1", inventory: 1)
    p2 = Product.new(name: "prod2", inventory: 1, price: "$1.00")
    p3 = Product.new(name: "prod3", inventory: 1, price: -1)
    assert_not p1.valid?
    assert_not p2.valid?
    assert_not p3.valid?
  end

end
