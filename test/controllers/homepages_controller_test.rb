require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase 

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_by_category for the first category" do
    get :show_by_category ,  id: categories(:electronics)
    assert_response :success
  end

  test "if there are no products for that category, redirect" do
    get :show_by_category , id: categories(:one)
    assert_equal assigns(:cat_products), []
    assert_redirected_to index_path

  end

  test "should get show_by_merchant and show products if the user has products" do
    get :show_by_merchant, id: users(:current_user)
    assert_not_equal assigns(:most_pop), "This merchant has no products yet"
    assert_response :success
  end

   test "if this is my merchant products page, then the program should know that" do
    session[:user_id]= users(:current_user).id
    get :show_by_merchant, id: users(:current_user)
    assert assigns(:is_my_page)
    assert_response :success
  end

  test "if a merchant has no products, it just puts a notice on the page saying that, but page loads" do
    get :show_by_merchant, id: users(:two)
     assert_equal assigns(:most_pop), "This merchant has no products yet"
    assert_response :success
  end
end
