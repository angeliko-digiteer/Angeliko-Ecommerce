class Users::ProductsController < ApplicationController
  def index
    @products = Product.all
    @checkout_history = current_user.checkouts.includes(:checkout_items)
  end

  def show
    @product = Product.find(params[:id])
  end
end
