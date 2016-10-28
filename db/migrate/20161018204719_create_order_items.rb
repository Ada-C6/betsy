class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.belongs_to :order, index: true
      t.belongs_to :product, index: true
    
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
  end
end
