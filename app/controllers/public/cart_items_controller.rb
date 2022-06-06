class Public::CartItemsController < ApplicationController
	def index
		@customer = current_customer
		@cart_items = @customer.cart_items
		@sum = 0
	end
	
	def update
		cart_item = CartItem.find(params[:id])
		cart_item.update(cart_item_params)
		redirect_to cart_items_path
	end 
	
	def destroy
		cart_item = CartItem.find(params[:id])
		cart_item.destroy
		redirect_to cart_items_path
	end
	
	def destroy_all
		CartItem.destroy_all
		redirect_to cart_items_path
	end
	
	def create
		@item = Item.find(cart_item_params[:item_id])
		@new_cart_item = CartItem.new(cart_item_params)
		@cart_item = CartItem.find_by(item_id: @item.id, customer_id: current_customer.id)
		if @cart_item
			@cart_item.amount += cart_item_params[:amount].to_i
			@cart_item.save
			redirect_to cart_items_path
		else	
			@new_cart_item.customer_id = current_customer.id
			@new_cart_item.save
			redirect_to cart_items_path
		end
	end
	
	private
	
	def cart_item_params
		params.require(:cart_item).permit(:item_id, :amount)
	end
end
