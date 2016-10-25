require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def login_a_user
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    get :create,  {provider: "google"}
  end

  test "A merchant can create a category with a name and image" do

  end

  test "A merchant cannot create a category without a name" do

  end

  test "A merchant cannot create a category without an image" do

  end

  test "A user cannot create a category with a name and image" do

  end

  test "redirects you to the category_not_found page if category doesn't exist" do

  end

  # test "A user and merchant is able to get the correct number of categories on the index page" do
  #   assert_equal(Category.length, 2)
  # end

  # test "A user and merchant is able to get index page" do
  #   get :index
  #   assert_response :success
  # end
  #
  # test "A merchant and user is able to get show page" do
  #   category = categories(:two)
  #
  #   get :show, category_id: category.id
  #   assert_response :success
  # end

end
