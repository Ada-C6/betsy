class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :stars
      t.string :author
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
