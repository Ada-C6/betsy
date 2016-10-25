require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase

    test "should get category index" do
        get :index
        assert_response :success
    end

    test "show page should show the proper category" do
        cat_id = categories(:cat).id
        get :show, {id: cat_id}
        assert_response :success
        assert_template :show

        category = assigns(:category)
        assert_not_nil category
        assert_equal category.id, cat_id
    end

    test "can't show a category that doesn't exist" do
        cat_id = 12345
        assert_raises ActiveRecord::RecordNotFound do
            Category.find(cat_id)
        end

        get :show, {id: cat_id}
        assert_response :not_found
    end
end
