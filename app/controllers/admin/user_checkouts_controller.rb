class Admin::UserCheckoutsController < ApplicationController
  def index
    @user_checkouts = Checkout.all 
  end

  def show
    @user_checkout = Checkout.find(params[:id])
  end
end
