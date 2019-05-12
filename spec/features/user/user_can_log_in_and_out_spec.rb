require 'rails_helper'

describe 'User' do
  before :each do
    @user = create(:user)
    visit login_path
  end

  it 'user can sign in' do
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(@user.email)
  end

  it 'can log out' do
    fill_in'session[email]', with: @user.email
    fill_in'session[password]', with: @user.password

    click_on 'Log In'

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Sign In')
  end

  it 'is shown an error when incorrect info is entered' do
    fill_in'session[email]', with: 'fake@email.com'
    fill_in'session[password]', with: 'fake_password'

    click_on 'Log In'

    expect(page).to have_content('Looks like your email or password is invalid')
  end
end
