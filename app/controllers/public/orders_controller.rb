class Public::OrdersController < ApplicationController
	def new
		@order = Order.new
		@customer = current_customer
	end
	
	def confirm
		@order = Order.new(order_params)
		@customer = current_customer
		@cart_items = @customer.cart_items
		@sum = 0
		@address = Address.find(params[:order][:address_id])
		
		if params[:order][:address_select] == "myaddress"
			@order.postal_code = @customer.postal_code
			@order.address = @customer.address
			@order.name = @customer.last_name + @customer.first_name
		elsif params[:order][:address_select] == "used_address"
			@address = Address.find(params[:order][:address_id])
			@order.postal_code = @address.postal_code
			@order.address = @address.address
			@order.name = @address.name
		elsif params[:order][:address_select] == "new_address"
			#処理なし
		else
			redirect_to :new
			#エラー処理
		end
		
		@order.shipping_cost = 800
	end
	
	def complete
		
	end
	
	def create
		order = Order.new(order_params)
		order.save
	end
	
	def index
		
	end
	
	def show
		
	end
	
	private
	
	def order_params
		params.require(:order).permit(:payment_method, :postal_code, :address, :name)	
	end
	
end
