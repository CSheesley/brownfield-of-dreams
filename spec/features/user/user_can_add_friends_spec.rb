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

    @user_1 = create(:user, first_name: 'corey', git_key: "bananas", git_id: 43529041)
    @user_2 = create(:user, first_name: 'noah', git_key: "apples", git_id: 34421236)
    @user_3 = create(:user, first_name: 'earl', git_key: "oranges", git_id: 34906415)

    visit login_path

    fill_in 'session[email]', with: @user_1.email
    fill_in 'session[password]', with: @user_1.password

    click_on 'Log In'
  end

  context 'when I visit my dashboard' do
    it 'shows an Add Friend button next to followers/followed names' do
      expect(current_path).to eq(dashboard_path)

      expect(@user_1.friends.count).to eq(0)
      expect(@user_2.friends.count).to eq(0)

      within '.followed' do
        expect(page).to have_css('.single_followed', count: 5)
        expect(page).to have_button("Add Friend", count: 1)
      end

      within '.followers' do
        expect(page).to have_css('.follower', count: 2)
        expect(page).to have_button("Add Friend", count: 1)
        click_on("Add Friend")
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_button("Add Friend", count: 1)
      expect(@user_1.friends.count).to eq(1)
      expect(@user_2.friends.count).to eq(1)
      expect(page).to have_content("#{@user_2.first_name} added as a friend!")
    end

    it 'shows a list of friends' do
      expect(current_path).to eq(dashboard_path)

      expect(@user_1.friends.count).to eq(0)

      within '.followed' do
        expect(page).to have_css('.single_followed', count: 5)
        expect(page).to have_button("Add Friend", count: 1)
        click_button("Add Friend")
      end

      within '.followers' do
        expect(page).to have_css('.follower', count: 2)
        expect(page).to have_button("Add Friend", count: 1)
        click_button("Add Friend")
      end

      within '.friends' do
        expect(page).to have_css('.friend', count: 2)
        expect(page).to have_content(@user_2.first_name)
        expect(page).to have_content(@user_2.last_name)
        expect(page).to have_content(@user_3.first_name)
        expect(page).to have_content(@user_3.last_name)
      end

      expect(page).to have_button("Add Friend", count: 0)
      expect(@user_1.friends.count).to eq(2)
    end

    it 'receives an error message if they attempt to send a post request with an invalid id' do
      expect(current_path).to eq(dashboard_path)

      test_post_request = Capybara.current_session.driver
      test_post_request.submit :post, '/add_friend?git_id=123456', nil
      
      expect(page).to have_content("Invalid user id")
    end
  end
end
