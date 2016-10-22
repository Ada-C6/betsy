class CreateOrderitems < ActiveRecord::Migration
  def change
    create_table :orderitems do |t|
      t.integer :quantity
      t.string :status
      t.references :product, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
