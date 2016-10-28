class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.string :photo_url
      t.integer :stock
      t.belongs_to :merchant
      t.timestamps null: false
    end
  end
end
