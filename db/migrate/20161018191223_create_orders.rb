class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
     t.string :buyer_name
     t.string :email
     t.string :street
     t.string :city
     t.string :state
     t.integer :zip
     t.integer :cc_four_digits
     t.integer :cc_expiration_date
     t.datetime :time_placed
     t.string :order_status
     t.boolean :shipped

     t.timestamps
    end
  end
end
