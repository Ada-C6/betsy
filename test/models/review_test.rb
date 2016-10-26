require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "Rating must be present to be valid" do
    #Best Review object has rating and is therefore valid.
    assert reviews(:best).valid?

    #no rating makes the object invalid
    reviews(:best).rating = nil
    assert_not reviews(:best).valid?
  end

   test "Review must correctly call attributes" do
     assert_equal reviews(:best).rating, 5
     assert_equal reviews(:best).feedback, "Awesome stuff :)"
     assert_equal reviews(:best).product, products(:goods)
     assert reviews(:worst).rating != 5
   end

  test "Rating must be an integer between 1 and 5." do
    #Average Review object is initially valid
    assert reviews(:average).valid?
    #If the rating is not an integer, the object is invalid.
    reviews(:average).rating = "one"
    assert_not reviews(:average).valid?
    reviews(:average).rating = 2.5
    assert_not reviews(:average).valid?
    #If the rating is less than 0 or greater than 5,
    reviews(:average).rating = 0
    assert_not reviews(:average).valid?
    reviews(:average).rating = 6
    assert_not reviews(:average).valid?
  end

  test "Review must belong to a product" do
    #Worst Review object is initially valid and belongs to "poo" product.
    assert reviews(:worst).valid?
    assert_equal reviews(:worst).product, products(:poo)
    #If the review is not assigned to a product, the object is invalid.
    reviews(:worst).product_id = nil
    assert_not reviews(:worst).valid?
  end

end
