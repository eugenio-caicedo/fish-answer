require 'rails_helper'

describe Question do
  it "increment the visit count" do
  	question = create(:question)
  	expect { question.update_visits_count }.to change { question.visits_count }
  end  
       
end 