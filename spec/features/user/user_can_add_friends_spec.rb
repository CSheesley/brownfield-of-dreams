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

  context 'when I visit my dashboard' do
    it 'shows a link next to followers/followed names' do
      corey = create(:user, git_key: "bananas", git_id: 43529041)
      noah = create(:user, git_key: "apples", git_id: 34421236)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(corey)

      visit dashboard_path
      
      within '.followers' do
        expect(page).to have_css('.follower', count: 2)
        expect(page).to have_link("Add Friend", count: 1)
        click_link("Add Friend")
      end

      # expect(current_path).to eq(dashboard)
    end
  end
end
