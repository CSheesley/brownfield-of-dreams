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
      user_1 = create(:user, git_key: "bananas", git_id: 43529041)
      user_2 = create(:user, git_key: "apples", git_id: 34421236)
      user_3 = create(:user, git_key: "oranges", git_id: 34906415)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      
      visit login_path

      fill_in 'session[email]', with: user_1.email
      fill_in 'session[password]', with: user_1.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)

      expect(user_1.friends.count).to eq(0)
      expect(user_2.friends.count).to eq(0)

      within '.followed' do
        expect(page).to have_css('.single_followed', count: 5)
        expect(page).to have_link("Add Friend", count: 1)
      end
      
      within '.followers' do
        expect(page).to have_css('.follower', count: 2)
        expect(page).to have_link("Add Friend", count: 1)
        click_link("Add Friend")
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link("Add Friend", count: 1)
      expect(user_1.friends.count).to eq(1)
      expect(user_2.friends.count).to eq(1)
      expect(page).to have_content("#{user_2.first_name} added as a friend!")
    end
  end
end
