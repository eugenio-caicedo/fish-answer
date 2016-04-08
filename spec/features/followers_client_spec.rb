require 'rails_helper'

feature 'When the client' do
  scenario 'follower the other user', :js => true do
  	user = sign_in
  	client = create(:question).client
  	visit client_path client
  	expect { click_on "Seguir"; wait_for_ajax; }.to change { user.client.reload.followers.count }
  end
end