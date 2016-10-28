class AddUniquenessToCatProd < ActiveRecord::Migration
  def change
    remove_index(:categories_products, [:product_id, :category_id])
    remove_index(:categories_products, [:category_id, :product_id])
    add_index(:categories_products, [:product_id, :category_id], :unique => true)
    add_index(:categories_products, [:category_id, :product_id], :unique => true)
  end
end
