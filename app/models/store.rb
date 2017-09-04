class Store < ApplicationRecord
  belongs_to :region

  validates :name, presence: true, length: {minimum: 3}, uniqueness: {case_sensitive: false}
  validates :number, presence: true, numericality: {only_integer: true}, inclusion: 10000..99999

  def status
  	if self.open
   		"Open"
  	else
  		"Closed"
  	end
  end
end
