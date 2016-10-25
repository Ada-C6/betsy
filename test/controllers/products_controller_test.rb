require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "index displays all the products if no merchant_id or category_id is given" do
    get :index
    assert_response :success
    assert_template :index

    products_from_controller = assigns(:products)
    assert_equal Product.count, products_from_controller.length
  end

  test "index displays all the products for a merchant (when called in the context of a merchant)" do
    # fake a merchant ID in the request
    get :index, merchant_id: merchants(:one).id
    assert_response :success
    assert_template :index

    # Same merchant returned from the index method
    assert_equal assigns(:merchant), merchants(:one)

    products_from_controller = assigns(:products)

    assert_equal products_from_controller.count, merchants(:one).products.count
    # Each product returned belongs to that merchant.
    products_from_controller.each do |product|
      assert_includes merchants(:one).products, product
    end
  end
  test "products#show displays a product if it exists!" do
    product_id = products(:one).id
    get :show, { id: product_id }

    assert_response :success
    product = assigns(:product)
    assert_not_nil product
    assert_equal product.id, product_id

    #this controller doesn't make a new artist
    assert_no_difference ('Product.count') do
      get :show, { id: product_id }
    end
  end

  # Need tests for new/create/edit(not done with code yet)
end
