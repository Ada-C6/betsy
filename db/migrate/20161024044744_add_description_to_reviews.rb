class AddDescriptionToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :description, :string
  end
end
