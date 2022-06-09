class OrderDetail < ApplicationRecord
	belongs_to :order
	belongs_to :item
	
	enum making_status: { not_making: 0, preparation: 1, making: 2, making_complete: 3 }
	
end
