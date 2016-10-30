class AddColumnsToOrderedProducts < ActiveRecord::Migration
  def change
    create_join_table :category, :products do |t|
      t.index :product_id
      t.index :category_id
    end
  end
end
