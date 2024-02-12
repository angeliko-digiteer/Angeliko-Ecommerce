class Admin::ProductsController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_product, only: [:show, :edit, :update, :destroy]
  
    def index
      @products = params[:search].present? ? Product.where("name ilike '%#{params[:search]}%'") : Product.all
      @user_checkouts = Checkout.all
    end

    def show
      render
    end
  
    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
  
      if @product.save
        redirect_to admin_products_path, notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    def edit
      @product = Product.find(params[:id])
    end
  
    def update
      @product = Product.find(params[:id])
  
      if @product.update(product_params)
        redirect_to admin_products_path, notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path, notice: 'Product was successfully deleted.'
    end

    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to admin_products_path
    rescue ActiveRecord::InvalidForeignKey
      redirect_to admin_products_path,
        alert: "Unable to delete product <strong>#{@product.name}</strong> due to item is in users cart"
    end
  
    private
  
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
  