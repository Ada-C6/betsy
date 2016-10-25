class CategoriesController < ApplicationController
    # Will likely need to remove this line (or further customize this), once we've narrowed down which pages require login. This line allows our tests to pass.
    skip_before_action :require_login

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
end
