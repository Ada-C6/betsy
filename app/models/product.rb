class Product < ActiveRecord::Base
    has_and_belongs_to_many :categories
    has_many :order_items
    belongs_to :merchant

    validates :name, presence: true, uniqueness: true
    validates :price, presence: true, numericality: {only_integer: true, greater_than: 0}

    default_scope { where(active?: true) }
end
