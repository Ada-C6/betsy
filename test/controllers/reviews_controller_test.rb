require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase

  test "should get new review form only if user is not selling merchant" do
    session[:user_id] = nil
    get :new, {id: products(:poo).id}
    assert_response :success
    assert_template :new

    session[:user_id] = products(:poo).merchant.id
    get :new, {id: products(:poo).id}
    assert_response :redirect
    assert_redirected_to products_show_path(products(:poo).id)
    assert_equal flash[:notice], "Sorry, you cannot leave a review on your own product."

    session[:user_id] = merchants(:bob).id
    get :new, {id: products(:poo).id}
    assert_response :success
    assert_template :new
  end

  test "should create a review given valid data, if and only if user is not the selling merchant" do
    session[:user_id] = nil
    post :create, {id: products(:poo).id, review: {rating: 3, feedback: "Was pretty okay."}}
    assert_response :redirect
    assert_redirected_to products_show_path(products(:poo).id)

    session[:user_id] = products(:poo).merchant.id
    post :create, {id: products(:poo).id, review: {rating: 3, feedback: "Was pretty okay."}}
    assert_response :redirect
    assert_redirected_to products_show_path(products(:poo).id)
    assert_equal flash[:notice], "Sorry, you cannot leave a review on your own product."

    session[:user_id] = merchants(:bob).id
    post :create, {id: products(:poo).id, review: {rating: 3, feedback: "Was pretty okay."}}
    assert_response :redirect
    assert_redirected_to products_show_path(products(:poo).id)
  end

  test "in case of invalid data, should not create a review and should redirect to new form" do
    session[:user_id] = nil
    post :create, {id: products(:poo).id, review: {rating: -77, feedback: "Was pretty crappy."}}
    assert_response :error
    assert_template :new
  end

end
