class RemovePictureFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :picture, :string
  end
end
