class Item < ApplicationRecord

	validates :name, presence: true, length: {minimum: 5}
	validates :number, presence: true, numericality: {only_integer: true}, uniqueness: true, inclusion: 10000000000..99999999999
end
