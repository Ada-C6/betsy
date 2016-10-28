class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :unit_price
      t.text :description
      t.string :photo_url
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
