require 'rails_helper'

describe Question do
  it "Increment the visit count" do
  	question = create(:question)
  	expect { question.update_visits_count }.to change { question.visits_count }
  end
  
  describe "Last questions for client" do
  	let!(:client){ create(:client) }
  	let!(:questions){ create_list(:question, 5) }
  	
  	it "with one answer" do
  		questions.each do |question|
  			create(:answer, question: question, client: client)
  		end
  		last_questions = Question.last_questions_for_client(client, 1, 10)
  		last_questions.any?.should == true
  		questions.first.should == last_questions.first
  	end
  	
  	it "with more than one answer" do
  		questions.each_with_index do |question, index|
  			create(:answer, question: question, client: client)
  			create(:answer, question: question, client: client) if index%2 == 0
  		end
  		last_questions = Question.last_questions_for_client(client, 1, 3)
  		questions.first.should == last_questions.first
  	end
  	
  	it "with more questions created" do
  		questions.each_with_index do |question, index|
  			create(:answer, client: client)
  			create(:answer, question: question, client: client)
  			create(:answer, question: question, client: client) if index%2 == 0
  		end
  		last_questions = Question.last_questions_for_client(client, 1, 5)
  		questions.first.should_not == last_questions.first
  	end
  end
       
end 