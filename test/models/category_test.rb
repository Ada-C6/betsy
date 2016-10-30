require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "Categories must have a name" do
    assert_equal categories(:apparel).name, "Apparel"
  end

  test "Categories can have many products" do
    assert_equal categories(:apparel).products.length, 3
    assert categories(:apparel).products.include?(products(:shoes))
  end
  
end
