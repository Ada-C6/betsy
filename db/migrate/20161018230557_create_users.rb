class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip
      t.integer :phone
      t.boolean :merchant

      t.timestamps null: false
    end
  end
end
