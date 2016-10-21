require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "Cannot create a product without a name" do
    product = Product.new
    assert_not product.valid?
    assert_includes product.errors, :name
  end

  test "Cannot create a product without a price" do
    product = Product.new(name: "kitten tux")
    assert_not product.valid?
    assert_includes product.errors, :price
  end

  test "Cannot create a product with a duplicate name" do
    product = Product.new(name: "cat suit", price: 224)
    assert_not product.valid?
    assert_not product.save
    assert_includes product.errors, :name
    assert_equal ["has already been taken"], product.errors.messages[:name]
  end

  test "Price must be an integer" do
    product = Product.new(name: "dog sunglasses", price: "foo")
    assert_not product.valid?
    assert_not product.save
    assert_equal ["is not a number"], product.errors.messages[:price]
  end

  test "Price can't be 0" do
    product = Product.new(name: "foobar", price: 0)
    assert_not product.valid?
    assert_not product.save
    assert_equal ["must be greater than 0"], product.errors.messages[:price]
  end

  test "Price can't be less than 0" do
    product = Product.new(name: "foobar", price: -1)
    assert_not product.valid?
    assert_not product.save
    assert_equal ["must be greater than 0"], product.errors.messages[:price]
  end

  test "create Product with valid data" do
    product = products(:cat_suit)

    assert product.valid?
    assert_not_nil product.name
    assert_not_nil product.price
  end

  test "create products with different names" do
    products.each do |product|
      assert product.valid?
      assert product.save
    end
  end

  test "Product can be assigned a merchant id" do
    product = Product.create!(name: "mouse hat", price: 1240)
    merchant = Merchant.create!(user_name: "testing", email: "test@test.com", uid: 124, provider: "github")

    product.merchant = merchant
    assert product.save

    assert_equal product.merchant_id, merchant.id
    assert_includes merchant.products, product
  end

  test "Product can have many categories" do
    product = products(:hamster_monocle)
    category_one = categories(:hamster)
    category_two = categories(:eyewear)
    assert_equal 2, product.categories.length
    assert_includes product.category_ids, category_one.id
    assert_includes product.category_ids, category_two.id
  end

  # test "Products can have many order_items" do
  #   product = Product.create!(name: "mouse hat", price: 1240)
  #   order_item = OrderItem.create!(quantity: 1, product_id: product.id, order_id: 1294, shipped?: false)
  #
  #   assert_equal order_item.product_id, product.id
  # end
end
