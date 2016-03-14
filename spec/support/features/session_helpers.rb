module Features
	module SessionHelpers
		def sign_in_with(username, password)
      		visit root_path
      		click_on "Iniciar Session"
      		fill_in 'user[username]', with: username
      		fill_in 'user[password]', with: password
      		click_on 'Login'
    	end
    	
    	def sign_in
      		user = create(:user)
      		sign_in_with user.username, user.password
      		return user
    	end
    	
    	def sign_out
    		click_on "Logout"
    	end
   	end
end