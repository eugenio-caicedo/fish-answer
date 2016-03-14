require 'rails_helper'

feature 'When the question show' do
  scenario 'the visit count was incremented by one' do
  	question = create(:question)
  	expect { visit question_path(question) }.to change { question.reload.visits_count }
  end
end