require 'rails_helper'

describe 'as a logged in user on my dashboard' do
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

  it 'sees a section for github and their collection of repos' do
    user = create(:user, git_key: 'bananas')

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit dashboard_path

    expect(page).to have_css('.github')
    expect(page).to have_css('.repository', count: 5)

    within first '.repository' do
      expect(page).to have_link('brownfield-of-dreams')
    end
  end

  it 'does not see a github section or any repos if missing github token' do
    user = create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(user)

    visit dashboard_path

    expect(user.git_key).to eq(nil)

    expect(page).not_to have_css('.github')
    expect(page).not_to have_css('.repository')
  end
end
