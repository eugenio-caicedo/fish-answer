class FollowersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_follower, only: [:show, :edit, :update, :destroy]

  # POST /followers
  # POST /followers.json	
  def create
  	@follower = Follower.new
  	@follower.client = @user.client
  	
  	
  	respond_to do |format|
      if @follower.update(follower_params)
        format.html { redirect_to @follower, notice: 'Follower was successfully created.' }
        format.json { render :show, status: :created, location: client_follower_path(@follower.client, @follower) }
      else
        format.html { render :new }
        format.json { render json: @follower.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follower
      @follower = Follower.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def follower_params
      params.require(:follower).permit(:client_follower_id, :client_id)
    end
end
