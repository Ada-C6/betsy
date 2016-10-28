class AddAltTextToProducts < ActiveRecord::Migration
  def change
    add_column :products, :alt_text, :string
  end
end
