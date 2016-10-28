class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @category_products = @category.products.uniq!
  end

  def new
    @category = Category.new
  end

  def create
    Category.create!(category_params)
      redirect_to categories_path
  end

private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
