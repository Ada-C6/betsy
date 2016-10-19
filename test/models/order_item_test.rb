require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
    test "Cannot create an order item with nil quantity" do
        nil_quantity = OrderItem.new(quantity: nil, product_id: 123, order_id: 456)
        assert_equal(nil, nil_quantity.quantity)
        assert_not nil_quantity.valid?
        assert_includes(nil_quantity.errors, :quantity)
    end

    test "Order item quantity is always instantiated at 1" do
        default_quantity = OrderItem.new(product_id: 123, order_id: 456)
        assert_equal(1, default_quantity.quantity)
    end

    test "Order item quantity must be a positive (non-zero) integer (LESS THAN OR EQUAL TO THE PRODUCT'S QUANTITY/STOCK, WOULD lIKE TO BUILD IN THIS PART OF THE TEST)" do
        assert order_items(:four_unit).valid?
        assert order_items(:one_unit).valid?

        zero_quantity = OrderItem.new(quantity: 0, product_id: 123, order_id: 456)
        assert_not zero_quantity.valid?
        assert_includes(zero_quantity.errors, :quantity)

        negative_quantity = OrderItem.new(quantity: -6, product_id: 123, order_id: 456)
        assert_not negative_quantity.valid?
        assert_includes(negative_quantity.errors, :quantity)
    end

    test "Order item creation requires a product_id [integer]" do
        no_product_id = OrderItem.new(quantity: 2, order_id: 456)
        assert_not no_product_id.valid?
        assert_includes(no_product_id.errors, :product_id)

        assert order_items(:one_unit).valid?
        assert order_items(:four_unit).valid?
    end

    test "Order item creation requires an order_id [integer]" do
        no_order_id = OrderItem.new(quantity: 2, product_id: 456)
        assert_not no_order_id.valid?
        assert_includes(no_order_id.errors, :order_id)

        assert order_items(:one_unit).valid?
        assert order_items(:four_unit).valid?
    end

    test "Creating an order item instantiate :shipped? as false" do
        o = OrderItem.new
        assert_equal(false, o.shipped?)
    end
end

    # note: have not written any tests on the belongs_to relationships, as we haven't set-up the product_id or order_id in the controller using params yet. I think these relationships can be tested in the controller instead of the model tests?

    # fyi from earlier project: on rails console, object.new goes straight to the model, bypassing the controller completely.
