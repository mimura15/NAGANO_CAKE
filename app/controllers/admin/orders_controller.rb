class Admin::OrdersController < 
	before_action :authenticate_admin!
	
	def show
		@order = Order.find(params[:id])
	end
	
	def update
		
	end
	
end
