class CategoriesController < ApplicationController
    before_action :require_login, only: [:new, :create]

    def index
        @categories = Category.all.order(:name)
    end

    def show
        begin
            @category = Category.find(params[:id])
            @products = @category.products
        rescue ActiveRecord::RecordNotFound
            render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
        end
    end

    def new
        @category = Category.new
        @categories = Category.all.order(:name)
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to categories_path
      else
        render :new
      end
    end


    private

    def category_params
      params.require(:category).permit(:name)
    end
end
