
FactoryGirl.define do  
  factory :rate do
  	stars     { Faker::Number.digit }
  	dimension { 'vote' }
  	association :rater, factory: :client
  	
  end
end

