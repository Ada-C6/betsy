class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order, index: true
      t.belongs_to :product, index: true
      t.integer :quantity
      t.boolean :shipping_status, :default => false
      
      t.timestamps null: false
    end
  end
end
