require 'faker'

FactoryGirl.define do  
  factory :follower do
  	association :client
  	association :client_follower, factory: :client
  end
end