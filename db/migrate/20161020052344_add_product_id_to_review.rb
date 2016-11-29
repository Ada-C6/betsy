class AddProductIdToReview < ActiveRecord::Migration
  def change
    add_reference :reviews, :product, index: true, foreign_key: true
  end
end
