require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "can create a valid review" do
    assert reviews(:best_product).valid?
  end

  test "cannot create a review with no rating" do
    assert_not reviews(:no_rating).valid?
    assert_includes reviews(:no_rating).errors, :rating
  end

  test "cannot create a review with a rating less than 1" do
    assert_not reviews(:too_low).valid?
    assert_includes reviews(:too_low).errors, :rating
  end

  test "cannot create a review with a rating greater than 5" do
    assert_not reviews(:too_high).valid?
    assert_includes reviews(:too_high).errors, :rating
  end

  test "cannot create a review with a non-integer rating" do
    r = Review.new
    r.rating = 2.5
    r.product_id = 3
    assert_not r.valid?
    assert_includes r.errors, :rating

    # assert_not reviews(:non_integer).valid?
    # assert_includes reviews(:non_integer).errors, :rating
  end

end
