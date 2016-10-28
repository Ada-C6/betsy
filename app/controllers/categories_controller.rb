class CategoriesController < ApplicationController
  def index
    # @category = Category.all
    @category = Category.order("lower(name) ASC").all
    @new_category = Category.new


  end

  def show
    @category = Category.find(params[:id].to_i)
    @products_in_category = @category.products
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash[:notice] = "Did not save successfully. Please check that this category does not already exist and try again."
      redirect_to categories_path
    end
  end



  def edit
  end

  def update
  end

  def destroy
    @category = Category.find(params[:id].to_i)
    @category.destroy

    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
