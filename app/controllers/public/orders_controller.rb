class Public::OrdersController < ApplicationController
	def new
		@order = Order.new
		@customer = current_customer
	end
	
	def confirm
		@order = Order.new(order_params)
		@address = Address.find(params[:order][:address_id])
		@order.postal_code = current_customer.postal_code
		@order.address = current_customer.address
		@order.name = current_customer.last_name + current_customer.first_name
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
