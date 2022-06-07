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
		@order.postal_code = @customer.postal_code
		@order.address = @customer.address
		@order.name = @customer.last_name + @customer.first_name
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
		params.require(:order).permit(:postal_code, :address, :name, :payment_method)	
	end
	
end
