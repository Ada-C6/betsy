class AddColumnUiDtoColumnDefaults < ActiveRecord::Migration
  def change
  	add_column :users, :uid, :integer, default: false
  end
end
