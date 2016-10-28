class AddCvVtoPaymentDetails < ActiveRecord::Migration
  def change
    add_column :payment_details, :CVV, :integer
  end
end
