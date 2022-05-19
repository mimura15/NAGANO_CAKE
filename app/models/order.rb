class Order < ApplicationRecord
	belongs_to :customer
	
	enum payment_method: { credit_card: 0, transfer: 1 }
	enum status: { not_payment: 0, payment_confirmation: 1, in_the_making: 2, ready_to_ship:3, shipped: 4 } 
end
