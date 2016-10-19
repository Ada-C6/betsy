require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
    test "Creating a new review will instantiate rating as nil" do
        r = Review.new
        assert_equal(nil, r.rating)
    end

    test "Cannot save a nil rating to the database" do
        no_rating = Review.new(description: "whatever", product_id: 123)
        assert_not no_rating.valid?
    end

    test "Can create reviews with ratings between 1 and 5" do
        assert reviews(:one_star).valid?
        assert reviews(:four_star).valid?
        assert reviews(:five_star).valid?
    end

    test "Can only create reviews with integer ratings" do
        float_rating = Review.new(rating: 3.2, description: "whatever", product_id: 123)
        string_rating = Review.new(rating: "excellent", description: "whatever", product_id: 123)
        assert_not float_rating.valid?
        assert_not string_rating.valid?
    end

    test "Cannot create reviews with ratings less than 1 or greater than 5" do
        too_low_rating = Review.new(rating: 0, description: "whatever", product_id: 123)
        too_high_rating = Review.new(rating: 6, description: "whatever", product_id: 123)
        assert_not too_low_rating.valid?
        assert_not too_high_rating.valid?
    end

    test "Review creation requires a description [string]" do
        no_description = Review.new(rating: 0, product_id: 123)
        assert_not no_description.valid?
        assert reviews(:one_star).valid?
    end

    test "Can only create reviews with descriptions 400 characters or less" do
        assert reviews(:character_400).valid?
        character_401 = Review.new(rating: 0, product_id: 123, description: "Here is a review of a book for sale. It is a great book, worth reading and possibly adding to your personal library. You will not be disappointed. Check this book out from your local library so you can form your own opinion and upvote it here. klsfjshrjdf lkajsf jej faiosejf esj oiasejf lsdjf ;oasjef ojsdfkl jasefj sodf lsdfj oisejf SDJf lKSDJFo iejw lKDSFJ l;SEF SIefj l;KSZDf sd eddjjrhdm fydowkf!")
        assert_not character_401.valid?
    end

    test "Review creation requires a product_id [integer]" do
        no_product_id = Review.new(rating: 0, description: "hello")
        assert_not no_product_id.valid?
        assert reviews(:one_star).valid?
    end
end

# note: have not written any tests on the belongs_to relationship, as we haven't set-up the product_id in the controller using params yet. I think this relationship can be tested in the controller instead of the model tests?

# fyi from earlier project: on rails console, object.new goes straight to the model, bypassing the controller completely.
