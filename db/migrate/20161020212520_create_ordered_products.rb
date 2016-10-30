class CreateOrderedProducts < ActiveRecord::Migration
  def change
    create_table :ordered_products do |t|

      t.timestamps null: false
    end
  end
end
