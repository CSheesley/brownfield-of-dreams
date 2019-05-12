require 'rails_helper'

describe 'visiter can create an account', :js do
  before :each do
    visit new_user_path
  end

  it 'can create an account with proper credentials' do
    fill_in 'user[email]', with: 'jimbob@aol.com'
    fill_in 'user[first_name]', with: 'Jim'
    fill_in 'user[last_name]', with: 'Bob'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on'Create Account'

    expect(page).to have_content(@email)
    expect(page).to_not have_content('Sign In')
  end

  it 'cannot create an account if the email is not unique' do
    existing_user = create(:user, email: 'email@aol.com')

    fill_in 'user[email]', with: existing_user.email
    fill_in 'user[first_name]', with: 'Jim'
    fill_in 'user[last_name]', with: 'Bob'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'

    click_on'Create Account'

    expect(page).to have_content('Email already taken')
  end
end
