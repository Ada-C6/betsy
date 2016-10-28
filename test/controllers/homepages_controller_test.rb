require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show_by_category for the first category" do
    get :show_by_category , id: Category.first
    assert_response :success
  end

  test "if there are no products for that category, redirect" do
    get :show_by_category , id: categories(:one)
    assert_equal assigns(:category_products), nil
    #assert_redirected_to index_path

  end

  test "should get show_by_merchant if you use the drop down and pick first merchant" do
    get :show_by_merchant, id: User.first
    assert_response :success
  end

  test "if a merchant has no products, it just puts a notice on the page saying that, but page loads" do
    get :show_by_merchant, id: users(:current_user)
     assert_equal assigns(:most_pop), "This merchant has no products yet"
    assert_response :success
  end
end
