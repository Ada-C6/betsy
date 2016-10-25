class ReviewsController < ApplicationController
  before_action :get_review, only: [:show, :edit, :update, :destroy]

  # Kelly: I don't know how to use controller filter here yet. So I will temporarily skip authentication requirements.
  skip_before_action :require_login

  # product_reviews_path	GET	/products/:product_id/reviews
  def index
    # @reviews = Review.all
    @product = Product.find(params[:product_id])
  end

  # product_review_path	GET	/products/:product_id/reviews/:id
  def show; end

  # new_product_review_path	GET	/products/:product_id/reviews/new
  def new
    if product.merchant_id == session[:merchant_id]
      render :no_show
    else
      product = Product.find(params[:product_id])
      @product_review = product.review.build
    end
  end

  # product_review_path POST	/products/:product_id/reviews(.:format)
  def create
    if product.merchant_id == session[:merchant_id]
      render :no_show
    else
      product = Product.find(params[:product_id])
      @review_product = product.reviews.create(review_params)
      redirect_to product_path(product.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def get_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
