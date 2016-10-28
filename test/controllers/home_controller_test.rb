require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "(index) should get the home index page" do
    get :index
    assert_response :success
    assert_template :index
  end

  test "If there are no 5 star products, @popular should be empty" do
    get :index

    assert_empty assigns(:popular)
  end

  test "A five star review should increase the count of @popular by one" do
    Review.create(rating: 5, rating_description: "asdf", product_id: products(:cat).id)

    get :index
    assert_equal assigns(:popular).count, 1
  end
end
