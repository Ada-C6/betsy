require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  setup do
    @review = reviews(:correct_review)
    @product = products(:cat)
    @merchant = merchants(:teeny_merchant)
  end

  test "Index should show index page for a particular product's reviews" do
    get :index, product_id: @product.id
    assert_response :success
    assert_template :index
    assert_not_nil assigns(:reviews)
  end

  test "Index should return one or more reviews" do
    get :index, product_id: @product.id

    assert_not_nil assigns(:reviews)
  end

  test "Index should have an @product @merchant set" do
    get :index, product_id: @product.id, merchant_id: @merchant.id

    assert assigns(:product).valid?
    assert assigns(:merchant).valid?

    assert_equal assigns(:product).id, products(:cat).id
    assert_equal assigns(:merchant).id, merchants(:teeny_merchant).id
  end

  test "New should get the new review form for a non-merchant" do
    get :new, product_id: products(:chair).id
    assert_template :new
  end

  test "New should get the new review form for a merchant who does not own the product" do
    get :new, product_id: products(:chair).id, merchant_id: @merchant.id
    assert_not_equal products(:chair).merchant_id, @merchant.id
    assert_template :new
  end

  test "New should create a new review if not logged in" do
    session[:merchant_id] = nil
    get :new, product_id: @product.id, merchant_id: @merchant.id

    assert_not_nil assigns(:review)
    assert_template :new
  end

  test "New should not let a merchant review their own product" do
    get :new, product_id: @product.id, merchant_id: @merchant.id
    session[:merchant_id] = @merchant.id

    assert_not assigns(:review).valid?
  end

  test "Create should create review for unauth user" do
    session[:merchant_id] = nil

    assert_difference('Review.count') do
      post :create, review: { rating: 4, rating_description: "bah", product_id: 1 } , product_id: 1
    end
  end

  test "Create should create review for an auth user" do
    session[:merchant_id] = 983248743734

    assert_difference('Review.count') do
      post :create, review: { rating: 4, rating_description: "bah", product_id: 1 }, product_id: 1
    end
  end

  test "If on the merchants/product route, creating a new review should send you towards the route merchants/products/review" do
    post :create, review: { rating: 1, rating_description: "slkdfj", product_id: 1}, product_id: @product.id, merchant_id: @merchant.id

    assert_redirected_to merchant_product_reviews_path(@merchant, @product)
  end

  test "A review without a rating should raise a parameter missing error" do
    session[:merchant_id] = @merchant.id

    assert_raises(ActionController::ParameterMissing) { post :create, {rating: nil, rating_description: "slkdfj", product_id: 1}}
  end

  test "Show should show review" do
    get :show, id: @review, product_id: @product.id
    assert_response :success
    assert_template :show
  end
end
