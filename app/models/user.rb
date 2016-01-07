class User < ActiveRecord::Base
	belongs_to :client
	
	validates_presence_of :username, :password, :password_confirmation
	validates_uniqueness_of :username
	validates_confirmation_of :password
	
	scope :verification, ->(username, password){where(username: username, password: password).limit(1)}
	scope :active, ->(client){where(client: client).order("updated_at DESC").limit(1)}
		
	#METODOS PROPIOS DE LA CLASE
	def verification
		@users = User.verification(self.username, self.password)
		@users.length > 0
	end
	
	def firstUser
		@users[0]
	end
end
