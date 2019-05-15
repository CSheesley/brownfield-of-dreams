require 'rails_helper'

RSpec.describe 'as a guest user' do
  describe 'on the home page' do
    it 'can sign in and activate account with email' do
    # As a guest user
    # When I visit "/"
    visit root_path
    # And I click "Register"
    click_on 'Register'
    # Then I should be on "/register"
    expect(current_path).to eq(register_path)
    # And when I fill in an email address (required)
    fill_in 'user[email]', with: 'test@email.com'
    # And I fill in first name (required)
    fill_in 'user[first_name]', with: 'noah'
    # And I fill in last name (required)
    fill_in 'user[last_name]', with: 'flint'
    # And I fill in password and password confirmation (required)
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    # And I click submit
    click_on 'Create Account'
    # Then I should be redirected to "/dashboard"
    expect(current_path).to eq(dashboard_path)
    #And I should see a message that says "Logged in as <SOME_NAME>"
    expect(page).to have_content('Logged in as noah')
    # And I should see a message that says "This account has not yet been activated. Please check your email."
    epxpect(page).to have_content("This account has not yet been activated. Please check your email.")
    end
  end
end