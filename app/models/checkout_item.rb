class CheckoutItem < ApplicationRecord
    belongs_to :checkout
    belongs_to :product
  end