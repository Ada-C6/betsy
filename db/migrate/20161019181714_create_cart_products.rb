class CreateCartProducts < ActiveRecord::Migration
  def change
    create_table :cart_products do |t|
      t.integer :product_quantity

      t.timestamps null: false
    end
  end
end
