require 'faker'

FactoryGirl.define do  
  factory :question do
  	title       { Faker::Hipster.sentence  }
  	description { Faker::Hipster.paragraph }
  	
  	association :client
  	
  	before(:create) do |question, evaluator|
  	  client = question.client
      user = create(:user, client: client)
    end
  end
end