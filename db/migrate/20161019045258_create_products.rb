class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :stock
      t.integer :price
      t.string :photo_url
      t.belongs_to :merchant

      t.timestamps null: false
    end
  end
end
