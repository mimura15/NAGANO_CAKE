class Admin::OrderDetailsController < ApplicationController
	before_action :authenticate_admin!
	
	def update
		@order_detail = OrderDetail.find(params[:id])
		@order_detail.update(order_detail_params)
		@order = @order_detail.order
		@order_details = @order.order_details
		if @order_details.count == @order_details.where(making_status: "making_complete").count
			@order_detail.order.update(status: "ready_to_ship")
			redirect_to admin_order_path(@order_detail.order.id)
		else
			redirect_to admin_order_path(@order_detail.order.id)
		end
	end
	
	private
	
	def order_detail_params
		params.require(:order_detail).permit(:making_status)
	end
	
end
