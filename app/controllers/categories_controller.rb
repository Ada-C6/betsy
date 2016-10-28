class CategoriesController < ApplicationController
  before_action :category_exist?, only: [:show]
  before_action :current_order

  def index
    @all_categories = Category.all
  end

  def show
    @products_by_category = @category.products
  end

  #TODO NEW AND CREATE SHOULD BE ONLY AUTHOURIZED FOR VIEW BY MERCHANTS
  def new  #route here from creating a new product
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to new_merchant_product_path(session[:user_id])
    else
      render :new
    end
  end


  private

  def category_params
    params.require(:category).permit(:name, :description, :photo_url)
  end

  def category_exist?
    #exception handeling:
    begin
      @category = Category.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to "/errors/category_not_found"
      return
    end
  end
end
