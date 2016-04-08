class MainController < ApplicationController
	before_filter :authenticate_user!, except: [:login]
	
	def login
	end
	
	def dashboard
	end
end
