require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "products with names are valid" do
    product = products(:cat)
    assert product.valid?
  end

  test "products without names are not valid" do
    product = products(:dog)
    assert_not product.nil?
  end

  test "products with a price greater than 0 are valid" do
    product =  products(:narwal)
    assert product.valid?
  end

  test "products without a price are not valid" do
    product = Product.new()
    product.name = "Invalid Product"
    product.price = nil
    product.description = "This should not work"
    product.photo_url = 'notreal.jpg'
    product.stock = 3
    product.merchant_id = 1
    product.save
    assert_not product.valid?
  end

  test "products with a price of 0 are not valid" do
    product = products(:pig)
    assert_not product.valid?
  end

  test "products with a price that are not an integer are not valid" do
    product = products(:frog)
    assert_not product.valid?
  end
end
