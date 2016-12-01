class AddNametoReview < ActiveRecord::Migration
  def change
    add_column :reviews, :name, :string, :default => "Guest User"
  end
end
