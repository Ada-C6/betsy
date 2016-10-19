class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :image
      t.integer :merchant_id
      t.integer :inventory
      t.float :rating

      t.timestamps null: false
    end
  end
end
