require 'rails_helper'

describe Follower do

  context "find follower" do
  
  	let!(:client) { create(:client) }
  
  	it "non-existent" do
  		follower = create(:follower)
  	  	followers = Follower.find_follower(client, follower.client_follower)
  	  	followers.should_not be_any
  	end
  	
  	it "existent" do
  		follower = create(:follower, client: client)
  		followers = Follower.find_follower(client, follower.client_follower)
  	  	followers.any?.should == true
  	end
  	
  end 
       
end 