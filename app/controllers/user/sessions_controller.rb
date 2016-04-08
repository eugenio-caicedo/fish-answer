class User::SessionsController < Devise::SessionsController
	prepend_before_filter :require_no_authentication, only: [:new, :create]
	skip_before_filter :verify_signed_out_user, only: :destroy
	prepend_before_filter :allow_params_authentication!, only: :create
	prepend_before_filter only: [:create, :destroy] { request.env["devise.skip_timeout"] = true }
	
	respond_to :json, :html
	
	def new
		self.resource = resource_class.new(sign_in_params)
    	clean_up_passwords(resource)
    	yield resource if block_given?
    	respond_with(resource, serialize_options(resource))
	end
	
	def create
		self.resource = warden.authenticate!(auth_options)
		if self.resource
			if sign_in(resource_name, resource)
      			respond_to do |format|
        			format.json { render :status => 200, :json => { :success => true, :info => "Logged in", :user => UserSerializer.new(resource).serializable_hash}, :callback => params[:callback] }
        			format.html { respond_with resource, location: after_sign_in_path_for(resource) }
      			end
    		else
      			render :status => 200, :json => { :success => false, :info => "Login failed", :user => nil }
    		end
		else
      		render :status => 200, :json => { :success => false, :info => "Unknow user", :user => nil }
    	end
  	end
  	
  	def set_resource(request)
    	self.resource = warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
  	end  

end