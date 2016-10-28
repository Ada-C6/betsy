require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  ########## testing validations! ##########

  test 'categories must have names' do
    assert(categories(:normal_category).valid?)
    assert_not(categories(:nameless_category).valid?)
  end

  test 'new category without a name is not valid' do
    category = Category.new
    category.save
    assert_not(category.valid?)
  end

  test 'if a name is added to a category it should become valid' do
    category = categories(:nameless_category)
    assert_not(category.valid?)

    category.name = "now it has a name!"
    category.save

    assert(category.valid?)
  end

  test 'if a category\'s name is removed it is no longer valid' do
    category = categories(:normal_category)
    assert(category.valid?)

    category.name = nil
    category.save
    assert_not(category.valid?)
  end

  ######### testing relationship between products & categories ######

  test 'categories can have products' do
    assert_not_empty(categories(:normal_category).products)
  end

  test 'categories should have the correct products' do
    assert_includes(categories(:normal_category).products, products(:normal_product))
    assert_includes(categories(:normal_category).products, products(:free_product))
  end

  test 'categories do not need to have products to be valid' do
    assert(categories(:productless_category).valid?)
  end

end
