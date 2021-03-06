class Order < ApplicationRecord
	belongs_to :customer
	has_many :order_details
	
	enum payment_method: { credit_card: 0, transfer: 1 }
	enum status: { not_payment: 0, payment_confirmation: 1, in_the_making: 2, ready_to_ship:3, shipped: 4 } 
	
	validates :payment_method, presence: true
	validates :postal_code, presence: true
	validates :address, presence: true
	validates :name, presence: true
	validates :shipping_cost, presence: true
	validates :total_payment, presence: true
	validates :status, presence: true
	
	def total_cost
		total_payment - shipping_cost
	end
	
end
