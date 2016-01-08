class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :currentUserInfo
  
  def currentUserInfo
  	@user = nil
  	if (session[:user_id] != nil)
  		@user = User.find_by_id(session[:user_id])
  	end
  end
end
