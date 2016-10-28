class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.timestamps null: false
    end
  end
end
