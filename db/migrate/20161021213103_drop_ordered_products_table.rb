class DropOrderedProductsTable < ActiveRecord::Migration
  def change
    drop_table :ordered_products
  end
end
