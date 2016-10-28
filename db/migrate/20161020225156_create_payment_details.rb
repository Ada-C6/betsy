class CreatePaymentDetails < ActiveRecord::Migration
  def change
    create_table :payment_details do |t|
      t.belongs_to :order, index: true
      t.string :buyer_name
      t.string :email
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :cc_four_digits
      t.integer :cc_expiration_date
      t.datetime :time_placed

      t.timestamps null: false
    end
  end
end
