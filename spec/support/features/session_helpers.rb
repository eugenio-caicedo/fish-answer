module Features
	module SessionHelpers
		def sign_in_with(user)
      		login_as user, scope: :user
      		visit root_path
    	end
    	
    	def sign_in
      		user = create(:user)
      		sign_in_with user
      		return user
    	end
    	
    	def sign_out
    		click_on "Logout"
    	end
   	end
end