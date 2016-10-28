require 'test_helper'

class ReviewsHelperTest < ActionView::TestCase

  test "the truth" do
    assert true
  end

  test "if a review object is passed to show_lemons, it should return an image tag with the correct number of lemons" do
    review = reviews(:normal_review)
    lemons = show_lemons(review)
    assert_equal(lemons, image_tag("5lemon.jpg"))

    review = reviews(:_4_review)
    lemons = show_lemons(review)
    assert_equal(lemons, image_tag("4lemon.jpg"))

    review = reviews(:_3_review)
    lemons = show_lemons(review)
    assert_equal(lemons, image_tag("3lemon.jpg"))

    review = reviews(:_2_review)
    lemons = show_lemons(review)
    assert_equal(lemons, image_tag("2lemon.jpg"))

    review = reviews(:_1_review)
    lemons = show_lemons(review)
    assert_equal(lemons, image_tag("1lemon.jpg"))
  end
end
