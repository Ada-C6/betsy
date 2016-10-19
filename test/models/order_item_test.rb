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



    # test "Can only create reviews with integer ratings" do
    #     float_rating = Review.new(rating: 3.2, description: "whatever", product_id: 123)
    #     string_rating = Review.new(rating: "excellent", description: "whatever", product_id: 123)
    #     assert_not float_rating.valid?
    #     assert_not string_rating.valid?
    # end
    #
    # test "Cannot create reviews with ratings less than 1 or greater than 5" do
    #     too_low_rating = Review.new(rating: 0, description: "whatever", product_id: 123)
    #     too_high_rating = Review.new(rating: 6, description: "whatever", product_id: 123)
    #     assert_not too_low_rating.valid?
    #     assert_not too_high_rating.valid?
    # end
    #
    # test "Review creation requires a description [string]" do
    #     no_description = Review.new(rating: 0, product_id: 123)
    #     assert_not no_description.valid?
    #     assert reviews(:one_star).valid?
    # end
    #
    # test "Can only create reviews with descriptions 400 characters or less" do
    #     assert reviews(:character_400).valid?
    #     character_401 = Review.new(rating: 0, product_id: 123, description: "Here is a review of a book for sale. It is a great book, worth reading and possibly adding to your personal library. You will not be disappointed. Check this book out from your local library so you can form your own opinion and upvote it here. klsfjshrjdf lkajsf jej faiosejf esj oiasejf lsdjf ;oasjef ojsdfkl jasefj sodf lsdfj oisejf SDJf lKSDJFo iejw lKDSFJ l;SEF SIefj l;KSZDf sd eddjjrhdm fydowkf!")
    #     assert_not character_401.valid?
    # end
    #
    # test "Review creation requires a product_id [integer]" do
    #     no_product_id = Review.new(rating: 0, description: "hello")
    #     assert_not no_product_id.valid?
    #     assert reviews(:one_star).valid?
    # end
    #
    # test "Creating a new review will instantiate rating as nil" do
    #     r = Review.new
    #     assert_equal(nil, r.rating)
    # end
end

    # note: have not written any tests on the belongs_to relationship, as we haven't set-up the product_id in the controller using params yet. I think this relationship can be tested in the controller instead of the model tests?

    # fyi from earlier project: on rails console, object.new goes straight to the model, bypassing the controller completely.
