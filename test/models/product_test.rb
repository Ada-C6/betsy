require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "create a new product with valid data" do
    assert products(:one).valid?
    assert products(:two).valid?
  end

  test "new product without name is not valid" do
    no_name = products(:one)
    no_name.name = nil

    assert_not no_name.valid?
  end

  test "new product with same name as another product is not valid" do
    not_new = products(:one)
    not_new.name = products(:two).name

    assert_not not_new.valid?
  end

  test "new product without price is not valid" do
    no_price = products(:one)
    no_price.price = nil

    assert_not no_price.valid?
  end

  test "price cannot be negative" do
    we_pay_you = products(:one)
    we_pay_you.price = -1234

    assert_not we_pay_you.valid?
  end

  test "price has to be an integer" do
    how_much = products(:one)
    how_much.price = "$12"

    assert_not how_much.valid?

    how_much.price = 12.34

    assert_not how_much.valid?
  end

  test "price of 0 is not valid" do
    free = products(:one)
    free.price = 0

    assert_not free.valid?
  end

  test "product with no merchant is not valid" do
    whose = products(:one)
    whose.merchant_id = nil

    assert_not whose.valid?
  end

  test "product should have categories" do
    prod = products(:one)
    assert_respond_to(prod, :categories)
  end

  test "product should have at least one category" do
    #This product doesn't have any categories through product_categories, because I've just created it here. It's not valid because validations says we should have at least one product_category.
    prod = Product.new(name:"a valid name", merchant_id: merchants(:one), price: 1200, stock_quantity: 1)

    assert_not prod.valid?
  end

  test "product cannot have invalid stock_quantity" do
    product = products(:one)
    product.stock_quantity = -1

    assert_not product.valid?

    product.stock_quantity = "none"

    assert_not product.valid?

    product.stock_quantity = nil

    assert_not product.valid?
  end

end
