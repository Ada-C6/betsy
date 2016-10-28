class AddIdToCategoriesProduct < ActiveRecord::Migration
  def change
    add_column :categories_products, :id, :primary_key
  end
end
