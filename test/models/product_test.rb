require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "Create a Product with valid data" do
    product = products(:one)
    assert product.valid?
  end

  test "Product must have a name" do
    product = Product.new(price: 2, merchant_id: 4)
    assert_not product.valid?
    assert_includes product.errors, :name
  end

  test "Name must be unique" do
    product1 = products(:one)
    product2 = Product.new(name: "broomstick", price: 2, merchant_id: 4)

    assert_not product2.valid?
  end

  test "Product must have a price" do
    product = products(:two)
    assert product.valid?
    assert_equal product.price, 13.52
    product1 = Product.new(name: "Test product", merchant_id: 4)
    assert_not product1.valid?
    assert_includes product1.errors, :price
  end

  test "Prices can be the same" do
    product1 = products(:two)
    product2 = products(:three)
    assert_equal product1.price, product2.price
    assert product1.valid?
    assert product2.valid?
  end

  test "Price must be a float" do
    product = products(:two)
    assert_equal product.price.class, Float
  end

  test "Price must be greater than zero" do
    product1 = Product.new(name: "bad price", price: 0, merchant_id: 4)
    product2 = Product.new(name: "another bad price", price: -2.1, merchant_id: 4)
    procuct3 = products(:one)
    assert_not product1.valid?
    assert_not product2.valid?
    assert procuct3.valid?
  end

  test "Product must belong to a Merchant" do
    product1 = products(:one)
    product2 = Product.new()
    assert_not_nil product1.merchant_id
    assert_not product2.valid?
    assert_includes product2.errors, :merchant_id

  end

  test "Can update quantity" do
    product = products(:one)
    assert_equal product.update_quantity(3), 4
    assert_equal product.update_quantity(3), 7

  end

  test "Cannot update quantity to below zero" do
    product = products(:one)
    assert_equal product.update_quantity(-1), 0
    assert_not product.update_quantity(-4)

  end

  test "Will check availability for a quantity" do
    product = products(:one)
    assert product.check_availability(0)
    assert product.check_availability(1)
    assert_not product.check_availability(3)
  end

  test "Can retire Product" do
    product = products(:two)
    product.retire_product
    assert_equal product.active, false
  end

  test "Can unretire Product" do
    product = Product.new(name: "Test product", merchant_id: 4, quantity: 0, active: false)
    assert_not product.active
    product.unretire_product
    assert product.active
  end

  test "Default sttatus of active attribute is true" do
    product = products(:two)
    assert product.active
  end

end
