class AddPictureToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :picture, :string
  end
end
