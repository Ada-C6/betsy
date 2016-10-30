class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.belongs_to :product, index: true
      t.belongs_to :order, index: true
      
      t.timestamps null: false
    end
  end
end
