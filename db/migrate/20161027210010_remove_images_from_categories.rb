class RemoveImagesFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :image_file_name, :string
    remove_column :categories, :image_content_type, :string
    remove_column :categories, :image_file_size, :integer
    remove_column :categories, :image_updated_at, :datetime
  end
end
