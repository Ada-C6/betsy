require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "an order can have orderitems" do
    assert orders(:testorder1).orderitems.length == 2
    assert orders(:testorder1).orderitems.include?(orderitems(:orderitem1))
    assert orders(:testorder1).orderitems.include?(orderitems(:orderitem2))
  end

  test "order must have orderitem to be valid" do
    orders(:testorder1).orderitems = []
    assert_not orders(:testorder1).valid?
  end

  test "if status is not paid, an order does not need user data to be valid" do
    assert orders(:pendingorder).valid?
    orders(:pendingorder).status = 'paid'
    assert_not orders(:pendingorder).valid?
  end

  test "when status is paid, an orderitem needs a name to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).name = nil
    assert_not orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a correctly formatted email to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).email = nil
    assert_not orders(:testorder1).valid?
    orders(:testorder1).email = 'bob'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).email = 'bob@msn'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).email = 'bob@msn.com'
    assert orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs an address to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).address = nil
    assert_not orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a city to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).city = nil
    assert_not orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a state to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).state = nil
    assert_not orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a 5-digit numerical zip to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).zip = nil
    assert_not orders(:testorder1).valid?
    orders(:testorder1).zip = '9991'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).zip = '999112'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).zip = 'kitty'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).zip = '10103'
    assert orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a card name to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).card_name = nil
    assert_not orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a 13-19 digit numerical card number to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).card_num = nil
    assert_not orders(:testorder1).valid?
    orders(:testorder1).card_num = 'my credit card'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).card_num = '1234'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).card_num = '12341234123412341234'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).card_num = '1234123412341234'
    assert orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs an expiry date to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).expiry = nil
    assert_not orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a 3-4 digit numerical CVV to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).cvv = nil
    assert_not orders(:testorder1).valid?
    orders(:testorder1).cvv = 'pigs'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).cvv = '1'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).cvv = '11111'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).cvv = '111'
    assert orders(:testorder1).valid?
  end

  test "when status is paid, an orderitem needs a 5-digit numerical billing zip to be valid" do
    assert orders(:testorder1).valid?
    orders(:testorder1).billing_zip = nil
    assert_not orders(:testorder1).valid?
    orders(:testorder1).billing_zip = 'kitty'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).billing_zip = '1234'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).billing_zip = '123456'
    assert_not orders(:testorder1).valid?
    orders(:testorder1).billing_zip = '12345'
    assert orders(:testorder1).valid?
  end

  test "an order correctly returns the total of its orderitems" do
    assert_equal orders(:testorder1).total, 4397
  end

  test "an order correctly reports whether it contains a particular product or not" do
    assert orders(:testorder1).has_product(products(:poo).id)
    assert_not orders(:testorder1).has_product(products(:shirt).id)
    assert_not orders(:testorder1).has_product(-1)
  end

  test "an order correctly subtracts the quantities of its products from stock upon sale" do
    # Only one product in order
    assert_difference('products(:poo).stock', -1) do
      orders(:testorder2).update_stock
      products(:poo).reload
    end
    # Multiple products in order
    assert_difference('products(:poo).stock', -2) do
      orders(:testorder1).update_stock
      products(:poo).reload
    end
    assert_difference('products(:shoes).stock', -1) do
      orders(:testorder1).update_stock
      products(:shoes).reload
    end
  end

  test "an order correctly reduces item quantities when stock is too low" do
    products(:poo).stock = 1
    products(:poo).save
    assert_difference('orderitems(:orderitem2).quantity', -1) do
      assert orders(:testorder1).remove_backordered?
      orderitems(:orderitem2).reload
    end
  end

  test "an order correctly removes an orderitem when the stock of that item is zero" do
    products(:poo).stock = 0
    products(:poo).save
    assert_difference('orders(:testorder1).orderitems.length', -1) do
      assert orders(:testorder1).remove_backordered?
      orders(:testorder1).orderitems.reload
    end
    # Delete order because it was the only orderitem
  end

  test "an order deletes itself if the stock of its only orderitem has fallen to zero" do
    products(:poo).stock = 0
    products(:poo).save
    assert_difference('Order.count', -1) do
      assert orders(:testorder2).remove_backordered?
    end
  end

  test "an order updates its prices if price has changed while the item was in the cart" do
    # Case where prices have changed
    assert_equal orderitems(:orderitem1).price, 1999
    assert_equal orderitems(:orderitem2).price, 1199
    assert orders(:testorder1).update_prices?
    orderitems(:orderitem1).reload
    orderitems(:orderitem2).reload
    assert_equal orderitems(:orderitem1).price, 2999
    assert_equal orderitems(:orderitem2).price, 899
    # Case where prices have not changed
    assert_equal orderitems(:orderitem4).price, 899
    assert_not orders(:testorder1).update_prices?
    assert_equal orderitems(:orderitem4).price, 899
  end

  test "update_cancel_stock method updates stock of orderitems that were not shipped when order was canceled" do
    orders(:goodorder).update_cancel_stock
    #original stock; shoes of shipped item: 20; goods of good item: 1. Only stock of goods should go up.
    assert_equal orderitems(:shippeditem).product.stock, 20
    assert_equal orderitems(:gooditem).product.stock, 2
  end


end
