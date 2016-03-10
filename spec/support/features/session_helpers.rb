module Features
	module SessionHelpers
		def sign_up_with(username, password)
      		visit root_path
    		click_on "Iniciar Session"
      		fill_in 'user[username]', with: username
      		fill_in 'user[password]', with: password
      		click_on 'Login'
    	end
   	end
end