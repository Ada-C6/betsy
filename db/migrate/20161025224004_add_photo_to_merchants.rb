class AddPhotoToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :photo, :string
  end
end
