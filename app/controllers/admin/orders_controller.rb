class Admin::OrdersController < ApplicationController
	before_action :authenticate_admin!
	
	def show
		@order = Order.find(params[:id])
	end
	
	def update
		@order = Order.find(params[:id])
		@order.update(order_params)
		if @order.status == "payment_confirmation"
			@order.order_details.update_all(making_status: "preparation")
			redirect_to admin_order_path(@order.id)
		else
			redirect_to admin_order_path
		end
	end
	
	private
	
	def order_params
		params.require(:order).permit(:status)
	end
	
end
