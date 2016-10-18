class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|

      t.timestamps null: false
    end
  end
end
