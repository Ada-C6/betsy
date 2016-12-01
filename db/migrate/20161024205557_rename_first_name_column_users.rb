class RenameFirstNameColumnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :first_name, :name
  end
end
