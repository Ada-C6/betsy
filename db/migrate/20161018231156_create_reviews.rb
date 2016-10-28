class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user_id, index: true, foreign_key: true
      t.text :description
      t.integer :rank

      t.timestamps null: false
    end
  end
end
