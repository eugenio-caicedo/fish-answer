class Client < ActiveRecord::Base
	has_many :users, :dependent => :destroy
	has_many :questions, :dependent => :destroy
	accepts_nested_attributes_for :users, :questions
	
	validates_presence_of :first_name, :first_last_name, :sex, :age
	validates_numericality_of :age
	
	validates_associated :users
	
	scope :find_by_id, ->(id){ find_by id: id }
	
	#METODOS ESTATICOS DE LA CLASE
	def self.sexValue
		["Masculino", "Femenino"]
	end
	
	#METODOS PROPIOS DE LA CLASE
	def fullName
		self.first_name + " " +self.first_last_name
	end
	
	def currentUser
		self.users[0]
	end
end
