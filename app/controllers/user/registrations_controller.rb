class User::RegistrationsController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
  
  def new
  	super
  end
  
  def create
  	resource = Client.new(client_params)
  	
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource = resource.users.first
      set_flash_message :notice, :signed_up if is_flashing_format?
      sign_up(resource_name, resource)
      respond_with resource, location: after_sign_up_path_for(resource)
    else
      resource = resource.users.first
      set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
      expire_data_after_sign_in!
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end
  
  protected
  
  def client_params
  	params.require(:client).permit(:id, :first_name, :first_last_name, :sex, :age, users_attributes: [:id, :username, :email, :password, :password_confirmation])
  end
  
end