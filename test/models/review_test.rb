require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # Rating must be present
  # Rating must be between 1 and 5
  test "Creates a review with a rating that is an integer and a product_id" do
    review = Review.new(rating: 4, product: products(:one))
    assert review.valid?
  end

  test "Cannot create a review without a rating" do
    review = Review.new(title: "Awesome Product", product: products(:one))
    assert_not review.valid?
  end

  # Rating must be an integer
  test "Cannot create a review with a rating that is not and integer" do
    review = Review.new(rating: "five stars", product: products(:one))
    assert_not review.valid?
  end

  # Rating must be between 1 and 5
  test "Cannot create a review with a rating that is > 5" do
    review = Review.new(rating: 6, product: products(:one))
    assert_not review.valid?
  end

  test "Cannot create a review with a rating that is < 1" do
    review = Review.new(rating: 0, product: products(:one))
    assert_not review.valid?
  end

  # belongs_to: Product
  test "Cannot create review without a product_id" do
    review = Review.new(rating: 5)
    assert_not review.valid?
  end

  test "Review belongs to a specific product" do
    review = reviews(:one)
    assert_equal(review.product_id, products(:one).id)
  end


end
