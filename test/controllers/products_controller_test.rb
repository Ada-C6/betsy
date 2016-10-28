require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, {id: products(:product4).id }
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    post_params = {product: {name: 'Legos', description: 'small blocks', category: 'Home Decor', price: 1.0, inventory: 2 }}
    post :create, post_params
    assert_response :redirect
  end

  test "should be able to edit a product" do
    get :edit, {id: products(:product3).id }
    assert_response :success
  end

  test "should get update" do
    patch :update, { id: products(:product4).id }
    assert_response :success
  end

  test "should get destroy" do
  	assert_difference( "Product.count", -1 ) do
    delete :destroy, { id: products(:product2).id }
    assert_response :redirect
  	end
  end

  test 'a product must have a name' do
  	
  end

  test 'a product must have a category' do
  end

  test 'a product must have a price' do
  end

  test 'a product must have a description' do
  end

  #example used was in TaskRails Task Controller, needs fleshing out with fixture info

  #   test "If a user is not logged in they cannot see their product." do
  #   session[:user_id] = nil  # ensure no one is logged in

  #   get :show, id: products(:product1).id
  #   # if they are not logged in they cannot see the resource and are redirected to login.  
  #   assert_redirected_to session_path
  #   assert_equal "You must be logged in first", flash[:notice]
  # end

  test "Make sure a user can see their products" do
    session[:user_id] = users(:rbg).id
    get :show, id: products(:product1).id
    
    assert_response :success
  end

  # test "Make Sure a User Cannot See Another User's products" do
  #   session[:user_id] = users(:SOMENAME).id
  #   get :show, id: products(:SOMEPRODUCT).id
  #   get :show, id: products(:SOMEPRODUCT).id
    
  #   assert_response :redirect
  #   assert_equal flash[:notice], "You do not have access to that information."
  # end


end
