require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "Create a Category with valid data" do
    category = categories(:one)
    assert category.valid?
  end

  test "Category must have a name" do
    category = Category.new
    assert_not category.valid?
    assert_includes category.errors, :name
  end

  test "Category name must be unique" do
    category1 = categories(:two)
    category2 = Category.new(name: "Klingon Warbirds")
    assert category1.valid?
    assert_not category2.valid?
    assert_includes category2.errors, :name
  end

end
