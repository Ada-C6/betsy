require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  # test "should get index of merchant's products if user is a merchant" do
  #   session[:user_id] = merchants(:bob).id
  #   get :index
  #   assert_response :success
  #   assert_template :index
  # end
  #
  # test "should not get index and instead redirect if user is not a merchant" do
  #   session[:user_id] = nil
  #   get :index
  #   assert_response :success
  # end

  test "should get show page for a valid product" do
    get :show, {id: products(:poo).id}
    assert_response :success
    assert_template :show
  end

  test "for a bad product id, should not get show page and instead redirect to all products page" do
    get :show, {id: -1}
    assert_response :redirect
    assert_redirected_to homepages_show_path
    assert_equal flash[:notice], "Sorry, that product could not be found. Please continue shopping our other awesome products."
  end

  test "can see show page whether guest or logged-in merchant (owner or non-owner)" do
    session[:user_id] = products(:poo).merchant.id
    get :show, {id: products(:poo).id}
    assert_response :success
    assert_template :show

    session[:user_id] = merchants(:bob).id
    get :show, {id: products(:poo).id}
    assert_response :success
    assert_template :show

    session[:user_id] = nil
    get :show, {id: products(:poo).id}
    assert_response :success
    assert_template :show
  end

  test "gets show page when there is an existing order, whether or not the product is in the order" do
    # Item is in order
    session[:order] = orders(:testorder1).id
    get :show, {id: products(:poo).id}
    assert_response :success
    assert_template :show
    # Item is not in order
    session[:order] = orders(:testorder1).id
    get :show, {id: products(:shirt).id}
    assert_response :success
    assert_template :show
  end

  test "gets show page when there is not an existing order" do
    session[:order] = nil
    get :show, {id: products(:poo).id}
    assert_response :success
    assert_template :show
  end

  test "show page redirects appropriately when given an invalid order (cart) id" do
    session[:order] = -1
    get :show, {id: products(:poo).id}
    assert_response :redirect
    assert_redirected_to products_show_path(products(:poo).id)
  end

  test "can see show page when an item has no reviews" do
    get :show, {id: products(:farts).id}
    assert_response :success
    assert_template :show
  end

  test "can see show page when an item has multiple reviews" do
    get :show, {id: products(:goods).id}
    assert_response :success
    assert_template :show
  end

  test "cannot see show page when an item is retired unless signed in as the merchant owning the product" do
    session[:user_id] = nil
    get :show, {id: products(:retired_item).id}
    assert_response :redirect
    assert_redirected_to homepages_show_path
    assert_equal flash[:notice], "Sorry, that product could not be found. Please continue shopping our other awesome products."

    session[:user_id] = products(:retired_item).merchant.id
    get :show, {id: products(:retired_item).id}
    assert_response :success
    assert_template :show

    session[:user_id] = merchants(:bob).id
    get :show, {id: products(:retired_item).id}
    assert_response :redirect
    assert_redirected_to homepages_show_path
    assert_equal flash[:notice], "Sorry, that product could not be found. Please continue shopping our other awesome products."
  end

  test "average should correctly return the average of reviews for a product" do
    controller = ProductsController.new
    assert_equal controller.average(products(:goods).reviews), "4.00"
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should get create" do
  #   get :create
  #   assert_response :success
  # end

end
