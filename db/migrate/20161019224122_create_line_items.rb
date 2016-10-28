class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :qty
      t.integer :price
      t.references :order
      t.references :product
      t.references :merchant

      t.timestamps null: false
    end
  end
end
