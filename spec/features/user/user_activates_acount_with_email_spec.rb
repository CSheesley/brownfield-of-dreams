require 'rails_helper'

RSpec.describe 'as a guest user' do
  describe 'on the home page' do
    it 'can sign in and be sent activation email' do
      visit new_user_path

      fill_in 'user[email]', with: 'test@email.com'
      fill_in 'user[first_name]', with: 'noah'
      fill_in 'user[last_name]', with: 'flint'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'

      click_on 'Create Account'

      expect(page).to have_content('This account has not yet been activated')
      expect(User.last.role).to eq('default')
    end

    it 'activates its account after clicking on activation link in email' do
      user = create(:user)

      visit login_path

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_on 'Log In'

      visit activate_path(email: user.email)

      user.reload

      expect(page).to have_content('Thank you! Your account is now activated.')

      click_link 'Profile'

      expect(page).to have_content('Status: Active')
    end
  end
end
