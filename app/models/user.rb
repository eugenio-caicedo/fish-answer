class User < ActiveRecord::Base
	belongs_to :client
	
	validates_presence_of :username, :password, :password_confirmation, on: :save
	validates_uniqueness_of :username, scope: :client
	validates_confirmation_of :password, on: :save
	
	scope :verification, ->(username, password){where(username: username, password: password).limit(1)}
	scope :actives, ->(client){where(client: client).order("updated_at DESC").limit(1)}
	scope :find_by_id, ->(id){ find_by id: id }
		
	#METODOS PROPIOS DE LA CLASE
	def verification
		@users = User.verification(self.username, self.password)
		@users.length > 0
	end
	
	def firstUser
		@users[0]
	end
	
	def fullName
		self.client.fullName
	end
end
