class DropCategoriesTables < ActiveRecord::Migration
  def change
    drop_table :categories_tables
  end
end
