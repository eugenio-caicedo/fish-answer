require 'rails_helper'

feature 'When the question show' do
  
  context 'the visit count was incremented by one ' do
  
  	let!(:question){ create(:question) }
  	
  	scenario 'with the invited user' do
  		expect { visit question_path(question) }.to change { question.reload.visits_count }
  	end
  	
  	scenario 'with the other user sign in and this should be allowed to vote', :js => true do
  		user = sign_in
  		expect { visit question_path(question) }.to change { question.reload.visits_count }
  		expect	{ 
  			find(:title, 'bad').click; wait_for_ajax; 
  		}.to change { question.reload.rates('vote').count; } 
  	end
  	
  end
  
  context 'the visit count was not incremented and should not be allowed to vote' do
  
  	let!(:user){ create(:user) }
  	let!(:question){ create(:question, client: user.client) }
  	
  	scenario 'with the invited user' do
  		visit question_path(question)
  		page.should_not have_content('.star')
  	end
  	
  	scenario 'with the same user sign in', :js => true do
  		sign_in_with user.username, user.password
  		expect { visit question_path(question) }.to change { question.reload.visits_count }.by(0)
  		page.should_not have_content('.star')
  	end
  	
  end
  
end