class RemoveUrlFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :url, :string
  end
end
