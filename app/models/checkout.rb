class Checkout < ApplicationRecord
    belongs_to :user
    has_many :checkout_items

    def total_price
        checkout_items.sum { |item| item.quantity * item.product.price }
    end
end