class RemoveForeignKeyProduct < ActiveRecord::Migration
  def change
  	remove_column :products, :user_id_id
  end
end
