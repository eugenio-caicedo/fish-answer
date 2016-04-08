class ClientsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json
  
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  	@client_decorator = ClientDecorator.new(@user, @client)
  end

  # GET /clients/new
  def new
    @client = Client.new
    newUser(true)
  end

  # GET /clients/1/edit
  def edit
  	newUser(false)
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
	
	if @client.save
		respond_with (@client) do |format|
			format.html { redirect_to checkURL, notice: 'Client was successfully created.' }
		end
	else
		respond_using @client, :new
	end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
  	if @client.update(client_params)
  		respond_with (@client)
  	else
  		respond_using @client, :edit
	end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_destroy clients_url, "El Cliente"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:id, :first_name, :first_last_name, :sex, :age, users_attributes: [:id, :username, :password, :password_confirmation])
    end
    
    def newUser(create)
    	@client.users = User.actives(@client)
    	if @client.users.empty? and create
    		@client.users.build
    	end
    end
    
    def checkURL
    	(defined? params[:client][:url]) ? params[:client][:url] : @client
    end
end
