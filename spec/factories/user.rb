require 'faker'

FactoryGirl.define do  
  factory :user do
  	username    { Faker::Internet.user_name }
    password    { Faker::Internet.password  }
    association :client
    
    before(:create) do |user, evaluator|
      user.password_confirmation = user.password
      user.client.save!
    end
    
  end
end