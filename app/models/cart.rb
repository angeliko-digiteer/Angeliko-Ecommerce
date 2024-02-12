class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def total_price
    cart_items.sum { |item| item.total_price }
  end
end