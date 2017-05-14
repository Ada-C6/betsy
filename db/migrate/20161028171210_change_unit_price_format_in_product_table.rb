class ChangeUnitPriceFormatInProductTable < ActiveRecord::Migration
  def change
    change_column :products, :unit_price, :float
  end
end
