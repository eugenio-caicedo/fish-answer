class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :current_user
  
  helper_method :current_user
  
  PAGE_SIZE = 10

protected
  
  def user_signed_in?
  	!session[:user_id].nil? || !@user.nil?
  end

  def current_user
  	@ajax = params[:ajax]
  	@user = nil
  	if user_signed_in?
  		@user = User.find_by_id(session[:user_id])
  		return @user.client
  	end
  	return @user
  end
  
  def respond_using model, resp_html
  	respond_to do |format|
  		format.html { render resp_html }
        format.json { render json: model.errors, status: :unprocessable_entity }
    end
  end
  
  def respond_destroy path_html, model
  	respond_to do |format|
      format.html { redirect_to path_html, notice: "#{model} ha sido eliminado." }
      format.json { head :no_content }
    end
  end
end
