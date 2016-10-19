class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :total_amount
      t.integer :guest_id
      t.integer :merchant_id
      t.string :card_name
      t.integer :card_number
      t.string :card_exp
      t.integer :card_cvv
      t.integer :billing_zip
      t.string :shipping_street
      t.string :shipping_city
      t.string :shipping_state
      t.integer :shipping_zip

      t.timestamps null: false
    end
  end
end
