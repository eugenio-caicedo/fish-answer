class Client < ActiveRecord::Base
	ratyrate_rater
	
	enum sex: ["Masculino", "Femenino"]
	
	has_many :users, :dependent => :destroy
	has_many :questions, :dependent => :destroy
	has_many :answers, :dependent => :destroy
	has_many :followers, :dependent => :destroy
	
	accepts_nested_attributes_for :users, :questions, :answers
	
	validates_presence_of :first_name, :first_last_name, :sex, :age
	validates_numericality_of :age
	
	validates_associated :users
	
	scope :find_by_id, ->(id){ find_by id: id }
	
	#METODOS PROPIOS DE LA CLASE
	def fullName
		"#{first_name} #{first_last_name}"
	end
	
	def currentUser
		self.users[0]
	end
end
