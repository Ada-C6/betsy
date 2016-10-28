class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean :paid
      t.datetime :placed
      t.string :email
      t.string :mailing_address
      t.string :mailing_city
      t.string :mailing_state
      t.string :mailing_zip
      t.string :cc_holder_name
      t.integer :cc_number
      t.date :exp
      t.integer :cvv
      t.string :billing_zip
      t.timestamps null: false
    end
  end
end
