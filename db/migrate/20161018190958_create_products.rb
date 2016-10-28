class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.belongs_to :merchant, index: true
      t.belongs_to :category, index: true
      t.string :name
      t.float :price
      t.integer :quantity

      t.timestamps
    end
  end
end
