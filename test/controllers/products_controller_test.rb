require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  test "You should see the new products form if you are a merchant" do
    session[:user_id]= users(:current_user).id
    get :new
    assert_response :success
  end

  test "You should get redirected if you are a guest if you try to make a new product" do
    request.env["HTTP_REFERER"]="blah"
    get :new
    assert_redirected_to "blah"
  end

  test "A guest/buyer cannot create a new product" do
    request.env["HTTP_REFERER"]="blah"
    post :create #put vailid params here
    assert_redirected_to "blah"
  end

  test "A merchant can create a new product if they put in valid info" do
    session[:user_id]= users(:current_user).id
    product_params={product:{name: "thing", unit_price: 2, quantity: 9}, user_id: users(:current_user).id}
    post :create, product_params
    assert_redirected_to index_path
  end

  test "A merchant a product is not created unless it includes a quantity" do
    session[:user_id]= users(:current_user).id
    product_params={product:{name: "thing", unit_price: 2}, user_id: users(:current_user).id}
    post :create, product_params
    assert_template :new
    assert_response :success
  end

  # Also test that name and unit price are present
  
  test "You can see the edit a product page if it is your product" do
    session[:user_id]= users(:current_user).id
    get :edit, id: products(:couple_cases)
    assert_response :success
  end
    
  test "You cannot see the edit a product page if it isn't your product" do
    request.env["HTTP_REFERER"]="blah"
    session[:user_id]= users(:current_user).id
    get :edit, id: products(:rando)
    assert_redirected_to "blah"
  end

  test "you can update your products if you are logged in and it is your product" do
    session[:user_id]= users(:current_user).id
    product_params={id: products(:couple_cases), product:{name: "Couple Cell phone case", unit_price: 9, quantity: 3}, user_id: users(:current_user).id }
    put :update, product_params
    assert_redirected_to product_path
  end

  test "you can't update your products if you aren't logged in/it isn't your product" do
    request.env["HTTP_REFERER"]="blah"
    product_params={id: products(:couple_cases), product:{name: "Couple Cell phone case", unit_price: 9, quantity: 3}, user_id: users(:current_user).id }
    put :update, product_params
    assert_redirected_to "blah"
  end

  test "you can't update a product without valid fields" do
    session[:user_id]= users(:current_user).id
    product_params={id: products(:couple_cases), product:{name: nil, unit_price: 9, quantity: 3}, user_id: users(:current_user).id }
    put :update, product_params
    assert_template :edit
    assert_response :success
  end

  test "you can see a product" do
    get :show, id: products(:rando)
    assert_response :success
  end

 test "if you own a product, you can destroy it" do
      assert_difference('users(:current_user).products.count',-1) do
        session[:user_id]= users(:current_user).id
        delete :destroy, id: products(:couple_cases)
        assert_redirected_to index_path
      end
  end

   test "if you don't own a product, you can't destroy it" do
      request.env["HTTP_REFERER"]="blah"
      delete :destroy, id: products(:rando)
      assert_redirected_to "blah"
  end
end
