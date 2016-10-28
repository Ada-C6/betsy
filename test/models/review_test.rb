require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def setup
    @review = reviews(:correct_review)
  end

  test "Review must have a star rating" do
    @review.rating = nil
    assert_not @review.valid?
  end

  test "Review does not need a description" do
    @review.rating_description = nil
    assert @review.valid?
  end

  test "Review cannot have a 0 or 6 star rating" do
    @review.rating = 0
    review_two = reviews(:correct_review)
    review_two.rating = 6

    assert_not @review.valid?
    assert_not review_two.valid?
  end

  test "Review can have a 1 or 5 star rating" do
    @review.rating = 1
    review_two = reviews(:correct_review)
    review_two.rating = 5

    assert @review.valid?
    assert review_two.valid?
  end

  test "Review should have an associated Product" do
    assert_not_nil @review.product_id
  end
end
