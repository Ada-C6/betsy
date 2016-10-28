class TransactionProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, class_name: "Transaction"
end
