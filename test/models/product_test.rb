require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "Product with minimal and all normal information must be valid" do
    #Product with minimal required information (name, price, merchant) is valid
    assert products(:minimalproduct).valid?
    #Product with all information is valid
    assert products(:goods).valid?
  end

  test "Product must correctly call its attributes" do
    assert_equal products(:goods).name, "Good"
    assert_equal products(:shirt).price, 1999
    assert products(:shoes).description != "These are not shoes"
  end

  test "Products without a name are invalid" do
    #Set known valid product's name to nil
    products(:goods).name = nil
    assert_not products(:goods).valid?
  end

  test "Products without a unique name are invalid" do
    #Create new product with same name as existing product "shoes"
    product = Product.new(name:"Unicorn Flats", price: 1, merchant: merchants(:bob))
    assert_equal product.name, products(:shoes).name
    #Product without a unique name is invalid
    assert_not product.valid?
    #Giving product a unique name will make it valid
    product.name = "Unique Product"
    assert product.valid?
  end

  test "Products without a price are invalid" do
    #Set known valid product's price to nil
    products(:goods).price = nil
    assert_not products(:goods).valid?
  end

  test "Product prices must be greater than 0" do
    #Set known valid product's price to string; should be invalid
    products(:goods).price = "one"
    assert_not products(:goods).valid?
    #Set known valid product's price to 0; should be invalid
    products(:goods).price = 0
    assert_not products(:goods).valid?
    #Set known valid product's price to 0.5; should be valid since it does not have to be integer!
    products(:goods).price = 0.5
    assert products(:goods).valid?
  end

  test "Products must belong to a merchant" do
    #Good product should belong to "bob" merchant
    assert_equal products(:goods).merchant, merchants(:bob)
    #Set known valid product's merchant to nil; should be invalid
    products(:goods).merchant = nil
    assert_not products(:goods).valid?
  end

  test "Products can have orderitems" do
    assert_equal products(:goods).orderitems.length, 1
  end

  test "Products can have reviews" do
    assert_equal products(:goods).reviews.length, 2
  end

  test "Products can have categories" do
    assert products(:farts).categories.ids.include? categories(:foods).id
  end

end
