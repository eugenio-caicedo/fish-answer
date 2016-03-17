require 'rails_helper'

feature 'When the question show' do
  context 'the visit count was incremented by one' do
  
  	let!(:question){ create(:question) }
  	
  	scenario 'with the invited user' do
  		expect { visit question_path(question) }.to change { question.reload.visits_count }
  	end
  	
  	scenario 'with the other user sign in', :js => true do
  		user = create(:user)
  		sign_in_with user.username, user.password
  		expect { visit question_path(question) }.to change { question.reload.visits_count }
  	end
  	
  end
  
  context 'the visit count was not incremented' do
  
  	let!(:user){ create(:user) }
  	let!(:question){ create(:question, client: user.client) }
  	
  	scenario 'with the same user sign in', :js => true do
  		sign_in_with user.username, user.password
  		expect { visit question_path(question) }.to change { question.reload.visits_count }.by(0)
  	end
  	
  end
  
end