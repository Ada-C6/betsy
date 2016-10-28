require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = categories(:correct_category)
  end

  test "Category must have a name" do
    @category.name = nil
    assert_not @category.valid?
  end

  test "Category must have a description" do
    @category.description = nil
    assert_not @category.valid?
  end

  test "Categories cannot have the same name" do
    v = Category.new(name:"Fancy Pants")
    assert_not v.valid?
  end

  test "Category must have an associated product" do
    assert_not_nil @category.products
  end
end
