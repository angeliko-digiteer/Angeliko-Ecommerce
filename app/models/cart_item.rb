class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    if quantity.present? && product&.price.present?
      quantity * product.price
    else
      0
    end
  end
end