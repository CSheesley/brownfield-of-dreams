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

  context 'when I visit my dashboard' do
    it 'sees a link to connect to github if user does not have a git_key' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_link("Connect To Github")
    end

    it 'does not see a link to connect to github if user has a git_key' do
      user = create(:user, git_key: "bananas")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).not_to have_link("Connect To Github")
    end
  end
end