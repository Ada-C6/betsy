require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  test "1. should get the index page" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "2. load show with given product" do
    get :show, { id: 1 }
    assert_response :success
    assert_template :show
  end

  test "3. user can add a new product" do
    session[:user_id] = users(:lil).id
    get :new
    assert_response :success
    assert_template :new
  end

  test "4. guests cannot add a product" do
    get :new
    assert_response 302
    assert_redirected_to root_path
  end

  test "6. not everyone should be able to create a new product" do
    product_params = {product: {id: 2, inventory: 80, description: "the best", user_id: nil}}
    total = Product.all.count
    post :create, product_params
    assert_equal total, Product.all.count
    assert_response :redirect
    assert_redirected_to root_path

  end

  test "7. should create a new user product" do
    session[:user_id] = users(:lil).id
    product_params = {product: { id: 567, name: "beveled coup", inventory: 80, description: "the worst best thing"}}
    assert_difference('Product.count', 1) do
      post :create, product_params
    end
    assert_redirected_to user_path(users(:lil).id)
  end

    test "8. Allow user to edit her/their own products" do
      session[:user_id] = users(:lil).id
      product_params = {id: products(:lil_product).id}
      get :edit, product_params
      assert_response :success
      assert_template :edit
    end

    test "9. Allow user to edit their and only their products" do
      session[:user_id] = users(:lil).id
      product_params = {id: products(:one).id}
      get :edit, product_params
      assert_response :redirect
      assert_redirected_to root_path
    end

  test "10. user should destroy a product if they want to" do
    assert_difference('Product.count', -1) do
      session[:user_id] = users(:lil).id
      delete :destroy, {id: products(:lil_product2).id}
      assert :success
    end
  end

  test "11. should create a new user product with categories" do
    session[:user_id] = users(:lil).id
    product_params = {product: { id: 567, name: "beveled coup", inventory: 80, description: "the worst best thing", categories_products: {first: categories(:one).id, second: categories(:two).id, third: categories(:three).id}, categories: {name: "New cat name for test"}}}
    assert_difference('Product.count', 1) do
      post :create, product_params
    end
    assert_redirected_to user_path(users(:lil).id)
  end # EN

  test "12. should be able to retire a product" do
    session[:user_id] = users(:ada).id
    product_params = { id: products(:ada_product), productstatus: "retire"}
    patch :retire, product_params
    assert assigns[:product].retired
  end

  test "13. User should be able to update their own product" do
    session[:user_id] = users(:ada).id

    patch :update, id: products(:ada_product).id, product: {name: "overwrite old name"}

    assert_equal assigns(:product).name, "overwrite old name"
    assert_redirected_to product_path(products(:ada_product).id)
  end

  test "12. should be able to activate a product" do
    session[:user_id] = users(:ada).id
    product_params = { id: products(:ada_product), productstatus: "retire"}
    patch :retire, product_params
    product_params = { id: products(:ada_product), productstatus: "activate"}
    patch :retire, product_params
    assert_not assigns[:product].retired
  end

  # test "12. user should not destroy a product if it does not belong to them" do
  #   login_nonexisting_user
  #   login_a_user
  #   assert_difference('Product.count', 0) do
  #     delete :destroy, {id: products(:esthern).id}
  #   end
  #   assert_redirected_to root_path
  #   assert_equal "You must be logged in to make seller changes", flash[:error]
  # end
  # test "12. should render :new if product does not save" do
  #   session[:user_id] = users(:lil).id
  #   product_params = {product: { name: "Kates" }}
  #   assert_difference('Product.count', 0) do
  #     post :create, product_params
  #   end
  #   assert_template :new
  # end # EN

  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    get :create,  {provider: "github"}
  end

  def login_nonexisting_user
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github', uid: '99999', info: { email: "new@b.com", name: "Na Ada" }
      })
  end

  def logout_a_user
    delete :destroy
  end
end
