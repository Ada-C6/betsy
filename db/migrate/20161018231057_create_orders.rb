class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :product_id, index: true, foreign_key: true
      t.references :user_id, index: true, foreign_key: true
      t.boolean :status
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :phone

      t.timestamps null: false
    end
  end
end
