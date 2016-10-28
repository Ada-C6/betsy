require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end


  # the review controller is in prodcuts

  # test 'should load a specific product on show' do
  #   test_product = products(:normal_product)
  #   get :show, id: test_product.id
  #   assert_response :success
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  # test "should update a specific product on patch request" do
  #   test_product_update = products(:normal_product)
  #   test_product_change = {name: 'Crispy Teddy Bears'}
  #   patch :update, id: test_product_update.id, product: test_product_change
  #   updated_product = Product.find(test_product_update.id)
  #   assert_equal 'Crispy Teddy Bears', updated_product.name

  # end
  # changed to archive

  # should this be done with puts/post?
  # test "should redirect on products destroy" do
  #   test_product_destroy = products(:normal_product)
  #   get :destroy, id: test_product_destroy.id
  #   assert_redirected_to '/'
  # end

  # #yml file has a product with a hardcoded id of 1 we can utilize that field here to simplify the test
  # test 'product should be made inactive when destroy called' do
  #   # Make product with id 1 not active.
  #   get :destroy, id: 1

  #   # Now that we have called the destroy method on the controller,
  #   # get the product from the database
  #   inactive_product = Product.find(1)

  #   # and assert that the product is not active.
  #   assert_equal false, inactive_product.active
  # end

  #
  # test 'if params[:search] on index, index does not have all  @products' do
  #   get :index, params: {search: "lemonade"}
  #
  #   assert_response :success
  #   assert_not_equal(@products.length, Product.all.length)
  # end
  #
  # test 'switch_active, when called on a product, returns a product with the opposite active status' do
  #   # product = products(:normal_product)
  #   patch :switch_active, params: {id: 1}
  #
  #   assert_not(product.active)
  #   assert_redirected_to(product_path)
  # end
  #
  # test 'delete products works?' do
  #   delete :destroy, params: {id: 100}
  #   redirect_to root_path
  # end

end
