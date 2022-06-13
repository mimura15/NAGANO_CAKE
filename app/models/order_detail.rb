class OrderDetail < ApplicationRecord
	belongs_to :order
	belongs_to :item
	
	enum making_status: { not_making: 0, preparation: 1, making: 2, making_complete: 3 }
	
	def subtotal
		item.with_tax_price * amount
	end
	
end
