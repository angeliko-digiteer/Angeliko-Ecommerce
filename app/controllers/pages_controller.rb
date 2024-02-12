class PagesController < ApplicationController
  def home
    @products = Product.all
  end

  def users
  end

  def admin
  end
end
