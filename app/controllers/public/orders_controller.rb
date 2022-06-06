class Public::OrdersController < ApplicationController
	def new
		@order = Order.new
		@customer = current_customer
	end
	
	def confirm
		
	end
	
	def complete
		
	end
	
	def create
		order = Order.new(order_params)
		order.save
		redirect_to confirm_orders_path
	end
	
	def index
		
	end
	
	def show
		
	end
	
end
