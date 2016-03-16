class ClientDecorator
	attr_reader :current_user, :client
	
	def initialize(current_user, client)
		@current_user = current_user
		@client = client
	end
	
	def same_client?
		if validate_not_nil?
			return @current_user.client.id == @client.id
		end
		return false
	end
	
	def client_follower?
		if validate_not_nil?
			return Follower.find_follower(@current_user.client, @client).any?
		end
		return false
	end

private
	def validate_not_nil?
		(!@current_user.nil? and !@client.nil?)
	end
end