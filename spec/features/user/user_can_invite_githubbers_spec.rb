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
  end

  context 'when sending an email invitation to a github user' do
    it 'is successful if that user has an email tied to github account' do
      json_user_info_response = File.open('./fixtures/user_info_with_email.json')
      stub_request(:get, 'https://api.github.com/users')
        .to_return(status: 200, body: json_user_info_response)

      git_token = "77da67af55f4d56425ef5e53137fea66ff7a1427"
      user = create(:user, role: 'active', git_key: git_token, git_id: 34421236)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      click_on "Send an Invite"

      expect(current_path).to eq(invite_path)

      fill_in 'handle', with: "test-freind"

      click_on "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end

    it 'fails if that user does not have an email tied to github account' do
      json_user_info_response = File.open('./fixtures/user_info_no_email.json')
      stub_request(:get, 'https://api.github.com/users')
        .to_return(status: 200, body: json_user_info_response)

      git_token = "77da67af55f4d56425ef5e53137fea66ff7a1427"

      user = create(:user, role: 'active', git_key: git_token, git_id: 34421236)
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      click_on "Send an Invite"

      expect(current_path).to eq(invite_path)

      fill_in 'handle', with: "not-a-real-name"

      click_on "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end
