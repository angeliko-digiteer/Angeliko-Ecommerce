class Users::CartsController < ApplicationController
    before_action :authenticate_user!
  
    def show
        @cart = current_user.cart || current_user.create_cart
        @total_price = @cart.total_price
    end
  
    def add_item
        product = Product.find(params[:product_id])
        quantity = params[:quantity].to_i
      
       
        current_user.create_cart unless current_user.cart
      
       
        current_user.cart.cart_items.create(product: product, quantity: quantity)
      
        redirect_to users_cart_path, notice: 'Product added to your cart.'
    end

    def remove_item
        cart_item = current_user.cart.cart_items.find_by(id: params[:id])
        
        if cart_item
          cart_item.destroy
          redirect_to users_cart_path, notice: 'Product removed from your cart.'
        else
          redirect_to users_cart_path, alert: 'Product not found in your cart.'
        end
    end
  
  def checkout
      @cart = current_user.cart
      if @cart.cart_items.empty?
        redirect_to users_cart_path, alert: 'Your cart is empty.'
        return
      end

      @checkout = Checkout.create(user: current_user)

      @cart.cart_items.each do |cart_item|
        @checkout.checkout_items.create(product: cart_item.product, quantity: cart_item.quantity)
      end

      @cart.cart_items.destroy_all

      redirect_to users_checkout_path(@checkout), notice: 'Checkout successful.'
    end 
end
