require 'rails_helper'

describe 'as a registered user on the dashboard page' do
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

    json_user_info_response = File.open('./fixtures/user_info.json')
    stub_request(:get, 'https://api.github.com/users')
      .to_return(status: 200, body: json_user_info_response)
    end
  context 'when sending an email invitation to a github user' do
    it 'is successful if that user has an email tied to github account' do
      # As a registered user
      git_token = "d115689f194f1572f02cdad273b850aa2fa6d848"
      user = create(:user, role: 'active', git_key: git_token, git_id: 34421236)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      # When I visit /dashboard
      visit dashboard_path
      # And I click "Send an Invite"
      click_on "Send an Invite"
      # Then I should be on /invite
      expect(current_path).to eq(invite_path)
      # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
      fill_in 'handle', with: "n-flint"
      # And I click on "Send Invite"
      click_on "Send Invite"
      # Then I should be on /dashboard
      expect(current_path).to eq(dashboard_path)
      # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
      expect(page).to have_content("Successfully sent invite!")
    end
  end
end
