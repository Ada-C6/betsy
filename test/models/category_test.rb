require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "Category can't have an empty name" do
    category = Category.new
    assert_not category.valid?
    assert_not category.save
    assert_includes category.errors, :name
  end

  test "Category is valid if it has a name" do
    categories.each do |category|
      category = Category.create!(name: category.name)
      assert category.valid?
      assert_not_nil category.name
    end
  end

  test "Category name must be unique" do
    category = Category.new(name: "formal wear")
    assert_not category.valid?
    assert_not category.save
    assert_equal ["has already been taken"], category.errors.messages[:name]
  end

  test "Category can have many products" do
    category = categories(:mammals)
    product_one = products(:cat_suit)
    product_two = products(:hamster_monocle)

    assert_equal 2, category.products.length
    assert_includes category.product_ids, product_one.id
    assert_includes category.product_ids, product_two.id
    assert_respond_to category, :products
  end
end
