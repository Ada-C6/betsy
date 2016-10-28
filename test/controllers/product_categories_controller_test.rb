require 'test_helper'

class ProductCategoriesControllerTest < ActionController::TestCase
  setup do
    @product_category = product_categories(:one)
  end

  test "should get new" do
    params = products(:one)
    get :new, { product_id: params.id }
    assert_response :success
  end

  test "should create product_category" do
    product = products(:one)
    category = categories(:one)

    assert_difference('ProductCategory.count', 1) do
      post :create, { product_id: product.id, category_ids: [category.id] }
    end

    assert_redirected_to products_path
  end

  test "should not create product_category if no category selected" do
    product = products(:one)

    assert_no_difference('ProductCategory.count') do
      post :create, { product_id: product.id }
    end

    assert_redirected_to products_path
  end

  test "should add the correct number of product_category items for the number of categories added to the product" do
    product = products(:three)
    category1 = categories(:one)
    category2 = categories(:two)

    category_ids = [category1.id, category2.id]
    num_of_categories = category_ids.length
    prev_num_of_prod_cat = ProductCategory.where(product_id: product.id).length


    assert_difference('ProductCategory.count', 2) do
      post :create, { product_id: product.id, category_ids: category_ids }
    end

    current_num_of_prod_cat = ProductCategory.where(product_id: product.id).length


    assert_equal current_num_of_prod_cat, (prev_num_of_prod_cat + num_of_categories)
  end
end
