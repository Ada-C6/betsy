class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :photo_url
      t.integer :inventory
      t.string :category
      t.references :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
