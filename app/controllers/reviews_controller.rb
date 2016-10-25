class ReviewsController < ApplicationController
  def index
    @reviews_by_product = Review.where(product_id: params[:product_id])
    product_id = params[:product_id]
    if @reviews_by_product.first == nil
      redirect_to product_path(product_id)
    else
      @product = @reviews_by_product.first.product
    end 
  end

  def show
    #TODO REMOVE IF WE AREN'T GOING TO USE THIS!!!!!
  end

  def new
    @review = Review.new
  end

  def create
    #exception handeling:
    begin
      @product = Product.find(params[:product_id])
    rescue ActiveRecord::RecordNotFound
      render "/errors/product_not_found"
      return
    end

    @review = Review.new(review_params)
    @product.reviews << @review

    if @review.save
      redirect_to product_reviews_path
    else
      render :new
    end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
