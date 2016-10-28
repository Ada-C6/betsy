class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :title
      t.string :body

      t.belongs_to :product, index: true

      t.timestamps null: false
    end
  end
end
