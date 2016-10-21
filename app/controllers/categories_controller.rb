class CategoriesController < ApplicationController
  def show
    begin
      @category = Category.find(params[:id])
      @products = @category.products
    rescue ActiveRecord::RecordNotFound => err
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end
end
