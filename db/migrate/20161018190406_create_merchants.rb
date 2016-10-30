class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :username
      t.string :email

      t.timestamps null: false
    end
  end
end
