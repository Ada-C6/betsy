class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.product = find_product
    @review.save
    if @review.save
      redirect_to product_path(@product.id)
    else
      render :template => "products/show/#{@product.id}"
    end

  end

  def edit
  end

  def update
  end

  private

  def find_product
    @product = Product.find(params[:product_id].to_i)
  end

  def product_params
    params.require(:product).permit(:id, :name, :description, :unit_price, :photo_url, :quantity)
  end

  def review_params
      params.require(:review).permit(:rating, :content).merge(user_id: session[:user_id], product_id: find_product.id)
      # need to add ", product_id: ____________" in the merge parens in order to associate to a product.
  end

end
