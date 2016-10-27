class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:category_id])
    @products = @category.products.where(active: true)
  end

  def create
    @category = Category.new(category_params)
    @product = Product.find(params[:product_id])
    if @category.save
      redirect_to merchants_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
