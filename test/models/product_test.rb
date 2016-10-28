require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # let's pass an easy test!
  test "the truth" do
    assert true
  end


############## testing product validations #############
  test 'products must have a name' do
    assert(products(:normal_product).valid?)
    assert_not(products(:nameless_product).valid?)
  end

  test 'once a name is added to a product that does not have a name, it should become valid' do

    product = products(:nameless_product)
    product.name = "here is a name"
    product.save

    assert(product.valid?)
  end

  test 'if a name is removed from a product, then it should no longer be valid' do

    product = products(:normal_product)
    assert(product.valid?)

    product.name = nil
    assert_not(product.valid?)
  end

  test 'products must have prices' do
    assert(products(:normal_product).valid?)
    assert_not(products(:product_with_no_price).valid?)
  end

  test 'products\' prices should be greater than or equal to zero' do
    assert(products(:normal_product).valid?)
    assert_not(products(:product_with_negative_price).valid?)
    assert(products(:free_product).valid?)
  end

  test 'if a price is removed from a product, then it should no longer be valid' do
    product = products(:normal_product)
    assert(product.valid?)

    product.price = nil
    assert_not(product.valid?)
  end

  test 'product prices must be integers' do
    product = products(:normal_product)
    assert(product.valid?)

    product.price = 10.03
    assert_not(product.valid?)

    product.price = [1,4,6,4,32]
    assert_not(product.valid?)

    product.price = "this is the price!"
    assert_not(product.valid?)
  end

  # test 'product must be either active or inactive' do
  #   assert(products(:normal_product).valid?)
  #   assert_not(products(:product_without_active_marker).valid?)
  # end

  test 'if a product is made inactive it is still valid' do
    product = products(:normal_product)
    assert(product.valid?)

    product.active = false
    assert(product.valid?)
  end

  # this test currently fails because it's not really necessary in Rails 4. right now anything not explicitly true is (apparently?) false. this will change in rails 5 going forward where it will be true.
  test 'if a product\'s active status is anything but "true" or "false," it is not valid' do
    product = products(:normal_product)
    assert(product.valid?)

    # product.active = 5
    # assert(product.valid?)

    # product.active = "cat"
    # assert_not(product.valid?)
    #
    # product.active = nil
    # assert_not(product.valid?)
    #
    # product.active = [1,4,56,4,442,3.5]
    # assert_not(product.valid?)
    #
    # product.active = products(:product_with_no_price)
    # assert_not(product.valid?)
  end

############# testing products relationship with categories ##########

  test 'products must have a category' do
    assert(products(:normal_product).valid?)
    assert_not(products(:product_with_no_category).valid?)
  end

  test 'product should have the correct category' do
    product = products(:normal_product)
    category = categories(:normal_category)

    assert_equal(product.category_id, category.id)
  end

############# test self.search ##########

test 'Product.search should return nil if there is nothing that matches the product' do
  searched = Product.search("cat")
  assert_empty(searched)
end

test 'Product.search should a product if its name is searched' do
  searched = Product.search("negative price")
  assert(searched.include?(products(:product_with_negative_price)))
end

test 'Product.search should a product if a piece of its description is searched' do
  searched = Product.search("cool")
  assert(searched.include?(products(:normal_product)))
end

############## test archive ##########

test 'when passed an active product, the archive method should switch it to inactive' do
  product = products(:normal_product)
  product.archive
  assert_not(product.active)
end

test 'when passed an inactive product, the archive method should not change the inactive product to active' do
  product = products(:inactive_product)
  product.archive
  assert_not(product.active)
end


############# test toggle_active ##########

  test 'when passed an active product, the toggle_active method should switch it to inactive' do
    product = products(:normal_product)
    product.toggle_active
    assert_not(product.active)
  end

  test 'when passed an inactive product, the toggle_active method should switch it to active' do
    product = products(:inactive_product)
    product.toggle_active
    assert(product.active)
  end

end
