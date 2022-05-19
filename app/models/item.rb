class Item < ApplicationRecord
	
	belongs_to :genre
	has_many :order_details
	has_one_attached :image
	
	validates :name, presence: true
	validates :introduction, presence: true
	validates :price, presence: true
	validates :image, presence: true
end
