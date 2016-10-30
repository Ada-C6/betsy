require 'test_helper'

class OrderitemTest < ActiveSupport::TestCase

  test "Orderitem must have quantity and belong to a product and order to be valid" do
    assert orderitems(:gooditem).valid?
    assert orderitems(:orderitem1).valid?
  end

  test "Orderitem must correctly call its attributes" do
    assert_equal orderitems(:gooditem).quantity, 1
    assert orderitems(:gooditem).quantity != 5
    assert_equal orderitems(:orderitem1).product, products(:shoes)
    assert_equal orderitems(:orderitem1).order, orders(:testorder1)
  end

  test "Orderitem that does not belong to a product is invalid" do
    #Set known valid orderitem's product to nil; should be invalid
    orderitems(:gooditem).product = nil
    assert_not orderitems(:gooditem).valid?
  end

  test "Orderitem that does not belong to an order is invalid" do
    #Set known valid orderitem's order to nil; should be invalid
    orderitems(:gooditem).order = nil
    assert_not orderitems(:gooditem).valid?
  end

  test "Orderitem without quantity value is invalid" do
    #Set known valid orderitem's quantity to nil; should invalid
    orderitems(:gooditem).quantity = nil
    assert_not orderitems(:gooditem).valid?
  end

  test "Orderitem without price value is invalid" do
    #Set known valid orderitem's quantity to nil; should invalid
    orderitems(:gooditem).price = nil
    assert_not orderitems(:gooditem).valid?
  end

  test "Quantity must be an integer and greater than 0 to be valid" do
    #Set known valid orderitem's quantity to string; should be invalid
    orderitems(:gooditem).quantity = "one"
    assert_not orderitems(:gooditem).valid?
    #Set quantity to 0; should be invalid
    orderitems(:gooditem).quantity = 0
    assert_not orderitems(:gooditem).valid?
    #Set quantity to decimal; should be invalid
    orderitems(:gooditem).quantity = 5.5
    assert_not orderitems(:gooditem).valid?
  end

  test "Total method should correctly calculate total price of orderitem" do
    #orderitem2.total = 2 * 1199 = 2398
    assert_equal orderitems(:orderitem2).total, 2398
  end

  test "Price attribute should return correct price of orderitem (and not potentially different current price of its product)" do
    #orderitem1.price = orderitem1.product.price = 2999
    assert_equal orderitems(:orderitem1).price, 1999
    assert orderitems(:orderitem1).price != orderitems(:orderitem1).product.price
  end

end
