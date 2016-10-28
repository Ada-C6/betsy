class ReviewsController < ApplicationController

  skip_before_action :require_login

  # new_product_review_path    GET     /products/:product_id/reviews/new
  def new
    product = Product.find(params[:product_id])
    if product.merchant_id == session[:merchant_id]
      render :no_show
    else
      @product_review = product.reviews.build
    end
  end

  # product_review_path POST	/products/:product_id/reviews(.:format)
  def create
      product = Product.find(params[:product_id])
    if product.merchant_id == session[:merchant_id]
      render :no_show
    else
      @review_product = product.reviews.create(review_params)
      redirect_to product_path(product.id)
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :description)
    end
end
