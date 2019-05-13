require 'rails_helper'

describe 'as a logged in user' do
  before :each do
    json_followed_response = File.open('./fixtures/user_followed.json')
    stub_request(:get, 'https://api.github.com/user/following')
      .to_return(status: 200, body: json_followed_response)

    json_followers_response = File.open('./fixtures/user_followers.json')
    stub_request(:get, 'https://api.github.com/user/followers')
      .to_return(status: 200, body: json_followers_response)

    json_repos_response = File.open('./fixtures/user_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(status: 200, body: json_repos_response)
  end
  context 'when I visit my dashboard and I have a git_key' do
    it 'does not see a link to connect to github' do
      user = create(:user, git_key: 'bananas')

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      expect(page).to_not have_link('Connect To Github')
    end
  end

  context 'when I visit my dashboard and do not have a git_key' do
    before :each do
      user = create(:user)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path
    end
    it 'sees a link to connect to github ' do
      expect(page).to have_link('Connect To Github')
    end

    it 'after clicking on connect to github link, I go through the OAuth process and see my dashboard' do
      OmniAuth.config.test_mode = true
      mock_auth_hash = { 'provider' => 'github',
                         'uid' => '123',
                         'info' => {},
                         'credentials' => { 'token' => '123456', 'expires' => false },
                         'extra' => {} }
      OmniAuth.config.mock_auth[:github] = mock_auth_hash

      click_link('Connect To Github')

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content('Connected to Github!')
      expect(page).to have_css('.github')
      expect(page).to have_css('.repositories')
      expect(page).to have_css('.followers')
      expect(page).to have_css('.followed')
    end
  end
end
