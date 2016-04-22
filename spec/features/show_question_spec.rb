require 'rails_helper'

feature 'When the question display' do

  let!(:user){ create(:user) }
  let!(:question){ create(:question, client: user.client) }
  
  context 'the visit count was incremented by one ' do
  	
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
  	
  	scenario 'with the invited user' do
  		visit question_path(question)
  		page.should_not have_content('.star')
  	end
  	
  	scenario 'with the same user sign in', :js => true do
  		sign_in_with user
  		expect { visit question_path(question) }.to change { question.reload.visits_count }.by(0)
  		page.should_not have_content('.star')
  	end
  	
  end
  
  context 'and have some answer, should see the raiting for each answer' do
  
  	let!(:answer){ create(:answer, question: question) }
  	
  	before { create(:rate, rateable: answer, rater: user.client) }
  	
  	scenario 'with the invited user', :js => true do
  		visit question_path(question)		
  		expect(page).to have_selector('.raiting div', count: 1,  visible: false)
  	end
  	
  	scenario 'when sign in with the same user of question', :js => true do
  		sign_in_with user
  		visit question_path(question)		
  		expect(page).to have_selector('.raiting div', count: 1,  visible: false)
  	end
  	
  end
  
  context 'should see the user of question' do
  	
  	scenario 'with the invited user', :js => true do
  		visit question_path(question)
  		click_on question.client.fullName
  		expect(page).to have_current_path(client_path(question.client), only_path: true)
  	end
  	
  	scenario 'when sign in with the same user of question', :js => true do
  		sign_in_with user
  		visit question_path(question)
  		within ".content_supporting-text" do
  			click_on question.client.fullName
  			expect(page).to have_current_path(client_path(question.client), only_path: true)
  		end
  	end
  	
  	scenario 'with the other user sign in', :js => true do
  		user = create(:user)
  		sign_in_with user
  		visit question_path(question)
  		click_on question.client.fullName
  		expect(page).to have_current_path(client_path(question.client), only_path: true)
  	end
  	
  end
  
end