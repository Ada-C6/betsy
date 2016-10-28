class CreateReviews < ActiveRecord::Migration
    def change
        create_table :reviews do |t|
            t.integer :rating
            t.string :description
            t.integer :product_id

            t.timestamps null: false
        end
    end
end


# Reviews:
# Rating: integer default to 1
# Description: string
# Product_ID
# (belongs to a product)
