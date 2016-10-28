class RenameActiveColumnInProducts < ActiveRecord::Migration
  def change
    rename_column(:products, :active?, :active)
  end
end
