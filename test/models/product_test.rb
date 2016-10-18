require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "Create a valid product" do
    assert products(:snake).valid?
  end

  test "Should not create a product with no name" do
    p = Product.new
    p.price = 100
    p.merchant_id = 1

    assert_not p.valid?
  end

  test "Should not create a product with invalid price" do
    p1 = Product.new(name: "prod1", merchant_id: 1)
    p2 = Product.new(name: "prod2", merchant_id: 1, price: "hi")
    p3 = Product.new(name: "prod3", merchant_id: 1, price: -1)
    assert_not p1.valid?
    assert_not p2.valid?
    assert_not p3.valid?
  end

end
