class ReviewsController < ApplicationController
  before_action :find_product
  before_action :find_review, only: [:show, :edit, :update]


  def index
    @reviews = Review.where(product_id: @product.id)
  end

  def show
  end

  def new
    @review = Review.new
    @post_path = product_reviews_path
    @post_method = :post
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = @product.id

    if @review.save
      redirect_to product_path(@product.id)
    else
      @error = "Did not save successfully. Please try again."
      @post_path = product_reviews_path
      @post_method = :post
      render :new_review
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def find_product
    @product = Product.find(params[:product_id])
  end
  def find_review
    @review = Review.find(params[:id])
  end
  def review_params
    params.require(:review).permit(:stars, :description, :author)
  end
end
