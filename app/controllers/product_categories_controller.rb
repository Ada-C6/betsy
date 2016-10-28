class ProductCategoriesController < ApplicationController
  before_action :current_order
  
  def new
    @all_categories = Category.all
    @product_category = ProductCategory.new
  end

  def create
    category_ids = product_category_params[:category_ids]
    product_id = product_category_params[:product_id]

    unless category_ids.nil?
      category_ids.each do | category_id |
        product_category = ProductCategory.new(product_id: product_id)
        product_category.category_id = category_id
        product_category.save
      end
    end

    redirect_to products_path
  end

  private

  def product_category_params
    # XXX SKY: This is a nasty hack :( fix it some day
    # Pretty sure we should be able to get the generated form to organize
    # the data this way, but not sure how
    params[:product_category] = {product_id: params[:product_id], category_ids: params[:category_ids]}
    params.require(:product_category).permit(:product_id, category_ids: [])
  end
end
