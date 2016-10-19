class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.references :merchant, index: true, foreign_key: true
      t.text :description
      t.string :photo
      t.integer :stock
      t.boolean :retired

      t.timestamps null: false
    end
  end
end
