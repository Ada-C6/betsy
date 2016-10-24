class ChangeCategoryToIdInProducts < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
    remove_column :products, :category, :integer
  end
end
