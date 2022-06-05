class Item < ApplicationRecord
	
	belongs_to :genre
	has_many :order_details
	has_many :cart_items
	has_one_attached :image
	
	validates :name, presence: true
	validates :introduction, presence: true
	validates :price, presence: true
	validates :image, presence: true
	
	def with_tax_price
		(price * 1.1).floor
	end
	
end
