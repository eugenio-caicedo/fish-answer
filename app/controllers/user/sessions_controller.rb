class User::SessionsController < Devise::SessionsController
	prepend_before_filter :require_no_authentication, only: [:new, :create]
	skip_before_filter :verify_signed_out_user, only: :destroy
	prepend_before_filter :allow_params_authentication!, only: :create
	prepend_before_filter only: [:create, :destroy] { request.env["devise.skip_timeout"] = true }
	
	respond_to :json, :html
	
	def new
		#redirect_to "/login"
		self.resource = resource_class.new(sign_in_params)
    	clean_up_passwords(resource)
    	yield resource if block_given?
    	respond_with(resource, serialize_options(resource))
	end
	
	def create
		resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
    	set_flash_message(:notice, :signed_in) if is_navigational_format?
    	sign_in(resource_name, resource)

    	respond_to do |format|
      		format.html do
        		respond_with resource, location: redirect_location(resource_name, resource)
      		end
      		format.json do
        		render json: { response: 'ok', auth_token: current_user.authentication_token }.to_json, status: :ok
      		end
    	end
  	end
  	
  	def set_resource(request)
    	self.resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
  	end  

end