require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category can't have an empty name" do
    category = Category.new
    assert_not category.valid?
    assert_not category.save
    assert_includes category.errors, :name
  end

  test "category is valid if it has a name" do
    categories.each do |category|
      category = Category.create!(name: category.name)
      assert category.valid?
      assert_not_nil category.name
    end
  end

  test "category name must be unique" do
    category = Category.new(name: "formal wear")
    assert_not category.valid?
    assert_not category.save
    assert_equal ["has already been taken"], category.errors.messages[:name]
  end
end
