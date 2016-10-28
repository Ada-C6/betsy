class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :picture
      t.integer :inventory_qty
      t.boolean :active
      t.belongs_to :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
