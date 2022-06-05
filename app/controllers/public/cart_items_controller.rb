class Public::CartItemsController < ApplicationController
	def index
		@cart_items = CartItem.all
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
		@new_cart_item = CartItem.new(cart_item_params)
		@cart_item = CartItem.where(customer_id: current_customer.id)
		if @cart_item.find_by(item_id: @new_cart_item.item_id)
			cart_item.amount += params[:amount].to_i
			cart_item.save
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
