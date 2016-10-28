class CreateOrderItems < ActiveRecord::Migration
    def change
        create_table :order_items do |t|
            t.integer :quantity, :default => 1
            t.integer :product_id
            t.integer :order_id
            t.boolean :shipped?, :default => false

            t.timestamps null: false
        end
    end
end
