class Client < ActiveRecord::Base
	has_many :users, :dependent => :destroy
	accepts_nested_attributes_for :users
	
	validates_presence_of :firstName, :lastFirstName, :sex, :age
	validates_numericality_of :age
	
	def self.sexValue
		["Masculino", "Femenino"]
	end
	
end
