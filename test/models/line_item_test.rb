require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "subtotal returns what's expected" do
    assert_equal 300, line_items(:one).subtotal
  end

end
