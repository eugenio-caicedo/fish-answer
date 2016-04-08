class User::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
  prepend_before_filter :validate_user_type, only: [:new, :create]  
  before_filter :configure_permitted_parameters, :set_type
  
  def new
  end
  
  protected
  
  def validate_user_type
    redirect_to "/" unless valid_type?
  end  
  
  def valid_type?
    ["client"].include?(params[:type].downcase)
  end
  
  def set_type
    @type = params[:type]
  end
  
  def build_resource(hash=nil)
    if @type
      resource_class = @type.capitalize.constantize
      puts resource_class
    end

    self.resource = resource_class.new_with_session(hash || {}, session)
  end
  
end