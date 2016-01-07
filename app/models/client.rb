class Client < ActiveRecord::Base
	has_many :users, :dependent => :destroy
	accepts_nested_attributes_for :users
	
	validates_presence_of :first_name, :last_first_name, :sex, :age
	validates_numericality_of :age
	
	validates_associated :users
	
	def self.sexValue
		["Masculino", "Femenino"]
	end
	
end
