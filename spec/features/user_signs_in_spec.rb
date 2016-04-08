require 'rails_helper'

feature 'User signs in' do
  scenario 'with invalid username', :js => true do
    sign_in_with 'invalid_username', 'password'
    current_path.should == new_user_session_path
  end

  scenario 'with blank password', :js => true do
  	user = create(:user)
    sign_in_with user.username, ''
    current_path.should == new_user_session_path
  end
  
  scenario 'with valid username and password', :js => true do
  	sign_in
    current_path.should == "/"
  end
end