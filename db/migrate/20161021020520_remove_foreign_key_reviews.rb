class RemoveForeignKeyReviews < ActiveRecord::Migration
  def change
  	remove_column :reviews, :user_id_id
  end
end
