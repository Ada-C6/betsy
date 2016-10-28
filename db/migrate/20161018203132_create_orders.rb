class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_status
      t.integer :shipping_cost
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
