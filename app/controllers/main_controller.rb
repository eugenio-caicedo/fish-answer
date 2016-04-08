class MainController < ApplicationController
	before_filter :authenticate_user!, except: [:login]
	
	def login
	end
	
	def dashboard
		redirect_to current_user.sign_in_path
	end
end
