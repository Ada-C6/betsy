require 'test_helper'

class ReviewTest < ActiveSupport::TestCase

  test "Create a Review with valid data" do
    review = reviews(:one)
    assert review.valid?
  end

  test "Review should have a rating" do
    review1 = reviews(:two)
    review2 = Review.new(product_id: 2)
    assert review1.valid?
    assert_not review2.valid?

    assert_includes review2.errors, :rating
  end

  test "Rating should be a number between 1 and 5" do
    review1 = Review.new(rating: 0, product_id: 22)
    review2 = Review.new(rating: 6, product_id: 23)
    review3 = reviews(:one)
    review4 = reviews(:two)
    assert_not review1.valid?
    assert_not review2.valid?
    assert review3.valid?
    assert review4.valid?

    assert_includes review1.errors, :rating
    assert_includes review2.errors, :rating
  end

  test "Review should have a product id" do
    review1 = reviews(:one)
    review2 = Review.new(rating: 3)
    assert review1.valid?
    assert_not review2.valid?

    assert_includes review2.errors, :product_id

  end

end
