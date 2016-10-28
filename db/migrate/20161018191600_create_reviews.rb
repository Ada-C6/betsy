class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :rating_description
      t.integer :rating
      t.belongs_to :product
      t.timestamps null: false
    end
  end
end
