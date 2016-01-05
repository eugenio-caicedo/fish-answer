class User < ActiveRecord::Base
	scope :verification, ->(username, password){where(username: username, password: password).limit(1)}
		
	#METODOS PROPIOS DE LA CLASE
	def verification
		users = User.verification(self.username, self.password)
		users.length > 0
	end
end
