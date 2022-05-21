class Admin::OrdersController < 
	def show
		@order = Order.find(params[:id])
	end
	
	def update
		
	end
	
end
