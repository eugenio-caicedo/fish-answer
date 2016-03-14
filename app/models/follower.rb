class Follower < ActiveRecord::Base
	belongs_to :client, foreign_key: :client_id, class_name: "Client"
	belongs_to :client_follower, foreign_key: :client_follower_id, class_name: "Client"
	
	scope :find_follower, ->(client, follower){ where(client: client, client_follower: follower) }
end
