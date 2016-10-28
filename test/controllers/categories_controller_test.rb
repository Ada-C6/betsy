require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should load specific category on show' do
    test_category = categories(:normal_category)
    get :show, id: test_category.id
    assert_response :success
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  test "should get create a new category on post request" do
    assert_difference('Category.count', 1) do
      post :create,
      { category:
        {name:'blunt objects'}
      }
    end
  end

  # test "should get edit" do
  #   get :edit
  #   assert_response :success
  # end

  test "should update category on patch request" do
    test_category_update = categories(:normal_category)

    test_category_change = {name: 'KITTIES!'}

    patch :update, id: test_category_update.id, category: test_category_change

    updated_category = Category.find(test_category_update.id)

    assert_equal 'KITTIES!', updated_category.name
  end

  test "should redirect on categories destroy" do
    test_category_destroy = categories(:normal_category)
    get :destroy, id: test_category_destroy.id
    assert_redirected_to '/'
  end

  test 'categories should decrease by one on destroy' do
    assert_difference('Category.count', -1) do
      test_category_destroy = categories(:normal_category)
      get :destroy, id: test_category_destroy
    end
  end

end
