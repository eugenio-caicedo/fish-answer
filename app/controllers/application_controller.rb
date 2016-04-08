class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  PAGE_SIZE = 10

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
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
