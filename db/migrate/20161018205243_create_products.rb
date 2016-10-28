class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :user, index: true
      t.string :name
      t.integer :price, default: 0
      t.integer :inventory, default: 0
      t.string :description
      t.string :photo_url
      t.boolean :retired
      t.timestamps null: false
    end
  end
end
