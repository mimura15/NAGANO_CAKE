class Public::AddressesController < ApplicationController
	def index
		@address = Address.new
		@customer = current_customer
		@addresses = @customer.addresses
	end
	
	def edit
		@address = Address.find(params[:id])
	end
	
	def create
		@address = Address.new(address_params)
		@address.customer_id = current_customer.id
		if @address.save
			redirect_to addresses_path
		else
			#データの確認→binding.irb サーバーを落とすとき→"ps aux | grep puma""kill [左から二番目の数字]" or "kill $(cat tmp/pids/puma.pid)"
			@addresses = Address.all
			render :index
		end
	end
	
	def update
		@address = Address.find(params[:id])
		@address.customer_id = current_customer.id
		if @address.update(address_params)
			redirect_to addresses_path
		else
			render :edit
		end
	end
	
	def destroy
		address = Address.find(params[:id])
		address.destroy
		redirect_to :index
	end
	
	private
	
	def address_params
		params.require(:address).permit(:postal_code, :address, :name)
	end
	
end
