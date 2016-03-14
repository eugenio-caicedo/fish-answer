require 'faker'

FactoryGirl.define do  
  factory :client do
  	first_name      { Faker::Name.first_name }
  	first_last_name { Faker::Name.last_name  }
  	age             { Faker::Number.digit    }
  	sex             { Faker::Name.genre      }
  end
end