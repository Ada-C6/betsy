class CategoriesController < ApplicationController
  before_action :require_merchant, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category.name = params[:category][:name]
    @category.save
    redirect_to product_edit_path
  end

  def show
    begin
      @category = Category.find(params[:id].to_i)
    rescue ActiveRecord::RecordNotFound
      render :file => 'public/404.html', :status => :not_found
    end
  end

  def destroy
  end
end
