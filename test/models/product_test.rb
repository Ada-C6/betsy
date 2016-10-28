require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "1. inventory is a valid integer" do
    product = Product.new
    product.inventory = -1
    assert_not product.valid?
  end

  test "2. Can create an instance of products" do
    products = Product.new
    products.name = "natasha"
    products.user_id = products(:lil_product).user_id
    assert products.valid?
  end

  test "3. Cannot create empty products" do
    products = Product.new
    assert_not products.valid?
  end

  test "4. Create a products when inputs are valid" do
    products = Product.new(name: "foo", inventory: 1, price: 200, description: "foo, bar, stuff" )
    assert products.valid?
  end
  test "5. Cannot create two Products of the same name" do
    products = Product.create!(name: "foo", inventory: 20, price: 200)
    product2 = Product.new(name: "foo", inventory: 1, price: 20)
    assert_not product2.valid?
    assert products.valid?
  end
  test "6. Create two different products" do
    products1 = Product.create!(name: "foo")
    products2 = Product.new(name: "bar")
    assert products2.valid?
    assert products1.valid?
  end
  ##ensured in db
  # test "7. won't allow a product to have non-int inventory" do
  #   products = Product.create!(name: "slick-swizzler", inventory: (0.012), price: 1)
  #   assert_not products.valid? ensured in db
  # end
  # test "8. won't allow  bourgeois pricing" do
  #   product = Product.create!(name: "foo", inventory: 500, price: 20000000)
  #   assert_not product.valid?
  # end
end
