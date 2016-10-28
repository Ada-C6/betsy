class ReviewsController < ApplicationController
  before_action :find_merchant
  before_action :find_product
  before_action :find_review, only: [:show, :edit, :update, :destroy]


  def index
    @reviews = Review.where(product_id: @product.id)
  end
  # 
  # def show
  # end

  def new
    if current_merchant != nil && @merchant.name == current_merchant.name
      flash[:notice] = "Cannot Review Your Own Product"
      redirect_to merchant_product_path(@merchant.id, @product.id)
      return
    else
      @review = Review.new
      @post_path = merchant_product_reviews_path
      @post_method = :post
    end
  end

  def create
    @review = Review.new(review_params)
    @review.product_id = @product.id

    if @review.save
      redirect_to merchant_product_path(@merchant.id, @product.id)
    else
      @error = "Did not save successfully. Please try again."
      @post_path = merchant_product_reviews_path
      @post_method = :post
      render :new
    end
  end

  def edit
    if @merchant.id = @product.merchant_id
      flash[:notice] = "Cannot Review Your Own Product"
      redirect_to merchant_product_path(@merchant.id, @product.id)
    end
  end

  def update
  end

  def destroy
    @review = find_review
    if current_merchant != nil && current_merchant.id == @product.merchant_id
      flash[:notice] = "Cannot Delete Your Own Product's Reviews"
      redirect_to merchant_product_path(@merchant.id, @product.id)
      return
    else
      if @review.class == Review
        @review.destroy
        redirect_to merchant_product_path(@merchant.id, @product.id)
        return
      end
    end
  end

  private

  def find_product
    if Product.exists?(params[:product_id].to_i) == true
      return @product = Product.find(params[:product_id].to_i)
    else
      redirect_to merchant_path(@merchant.id)
      flash[:notice] = "Product Not Found"
      return
    end
  end

  def find_merchant
    find_product
    if Merchant.exists?(@product.merchant_id) == true
      return @merchant = Merchant.find(@product.merchant_id)
    else
      redirect_to categories_path
      flash[:notice] = "Merchant Not Found"
      return
    end
  end

  def find_review
    if Review.exists?(params[:id].to_i) == true
      return @review = Review.find(params[:id].to_i)
    else
      redirect_to merchant_product_path(@merchant.id, @product.id)
      flash[:notice] = "Review Not Found"
      return
    end
  end

  def review_params
    params.require(:review).permit(:stars, :description, :author)
  end
end
