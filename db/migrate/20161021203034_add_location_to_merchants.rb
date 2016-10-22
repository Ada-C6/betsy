class AddLocationToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :location, :string
  end
end
