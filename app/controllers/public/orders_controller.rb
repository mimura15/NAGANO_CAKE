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
		elsif params[:order][:address_select] == "new_address" && @order.postal_code? && @order.address? && @order.name?
			#処理なし
		else
			render :new
			#エラー処理
		end
		
		@order.shipping_cost = 800
		@order.status = Order.statuses.key(0)
	end
	
	def complete
		
	end
	
	def create
		@order = Order.new(order_params)
		@order.save
		cart_items = current_customer.cart_items
		cart_items.each do |cart_item|
			@order_details = @order.order_details.new
			@order_details.item_id = cart_item.item_id
			@order_details.price = cart_item.item.price
			@order_details.amount = cart_item.amount
			@order_details.making_status = OrderDetail.making_statuses.key(0)
			@order_details.save
		end
		cart_items.destroy_all
		redirect_to complete_orders_path
	end
	
	def index
		@orders = current_customer.orders	
	end
	
	def show
		@order = Order.find(params[:id])
	end
	
	private
	
	def order_params
		params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)	
	end
	
end
