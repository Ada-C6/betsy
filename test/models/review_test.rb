require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Reviews must have a star rating and a description" do
    assert reviews(:glitter_review).valid? "Glitter Review should be valid" ### WHY IS THIS FAILING???

    reviews(:glitter_review).stars = nil  ## This name removal is local to the test data - it doesn't change the fixture
    assert_not reviews(:glitter_review).valid? "Glitter Review should no longer be valid"

    reviews(:shoe_review).description = nil
    assert_not reviews(:shoe_review).valid? "Shoe Review should no longer be valid"
  end


  test "Reviews cannot have a rating less than 0 or greater than 5" do
    assert reviews(:glitter_review).stars = 6
    assert_not reviews(:glitter_review).valid? "Glitter Review should no longer be valid"

    assert reviews(:shoe_review).stars = -1
    assert_not reviews(:shoe_review).valid? "New Shoe Review should no longer be valid"
  end


  test "Each Review has the correct rating" do
    assert_equal reviews(:glitter_review).product, products(:glitter)
    assert_equal reviews(:shoe_review).product, products(:new_shoe)
    assert_equal reviews(:rating_review_one).product, products(:no_rating)
    assert_equal reviews(:rating_review_two).product, products(:no_rating)
  end


end
