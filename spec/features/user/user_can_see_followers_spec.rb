require 'rails_helper'

describe 'as a logged in user' do
  before :each do
    json_followed_response = File.open("./fixtures/user_followed.json")
    stub_request(:get, "https://api.github.com/user/following").
      to_return(status: 200, body: json_followed_response)

    json_followers_response = File.open("./fixtures/user_followers.json")
    stub_request(:get, "https://api.github.com/user/followers").
      to_return(status: 200, body: json_followers_response)

    json_repos_response = File.open("./fixtures/user_repos.json")
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(status: 200, body: json_repos_response)
  end

  context 'when I visit my dashboard - in the Github section' do
    it 'shows a followers section, with my followers handles, which link to their profiles' do
      user = create(:user, git_key: "bananas")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_css('.github')
      expect(page).to have_css('.follower')

      within first('.followers') do
        expect(page).to have_css('.profile-link')
      end
    end
  end

end
