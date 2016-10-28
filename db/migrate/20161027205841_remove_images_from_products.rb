class RemoveImagesFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :image_file_name, :string
    remove_column :products, :image_content_type, :string
    remove_column :products, :image_file_size, :integer
    remove_column :products, :image_updated_at, :datetime
  end
end
