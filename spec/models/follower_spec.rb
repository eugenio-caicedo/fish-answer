require 'rails_helper'
require 'client_decorator'

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
  
  context "find follower with decorator" do
  
  	let!(:client) { create(:client) }
  
  	it "non-existent" do
  		current_user = create(:user)
  		client_decorator = ClientDecorator.new(current_user, client)
  		client_decorator.same_client?.should == false
  		client_decorator.client_follower?.should == false
  	end
  	
  	it "existent" do
  		current_user = create(:user, client: client)
  		follower = create(:follower, client: client)
  		client_decorator = ClientDecorator.new(current_user, follower.client_follower)
  		client_decorator.same_client?.should == false
  		client_decorator.client_follower?.should == true
  	end
  end
       
end 