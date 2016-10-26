class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :card_name
      t.string :card_num
      t.datetime :expiry
      t.string :cvv
      t.string :billing_zip
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :status
      t.datetime :placed_at

      t.timestamps null: false
    end
  end
end
