require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test 'Review must belong to a product' do
  	assert_equal reviews(:review1.product_id, :product4.id) 
  	assert_valid(:review1) 
  	:review1.product_id = nil 
  	assert_invalid? :review1 
  end


  test 'Review must include a rank value' do
  	review = Review.new
  	refute review.valid? "A review without a rank is invalid."
  	# terrible.rank = 1
  	assert terrible.valid?
  end

  test 'Review must be invalid without a rank value' do
  end

  test 'Review rank must be a number' do
  end



  test 'Review is associated with a vendor via that vendor\'s product' do
  end



end
