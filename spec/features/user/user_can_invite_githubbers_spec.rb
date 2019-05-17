require 'rails_helper'

describe 'as a registered user on the dashboard page' do
  context 'when sending an email invitation to a github user' do
    it 'is successful if that user has an email tied to github account' do
      # As a registered user
      user = create(:user, role: 'active')
      # When I visit /dashboard
      visit dashboard_path
      # And I click "Send an Invite"
      click_on "Send an Invite"
      # Then I should be on /invite
      expect(current_path).to eq(invite_path)
      # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
      fill_in 'githubber[github_handle]' with: "n-flint"
      # And I click on "Send Invite"
      click_on "Send Invite"
      # Then I should be on /dashboard
      expect(current_path).to eq(dashboard_path)
      # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
      expect(page).to have_content("Successfully sent invite!")
    end
  end
end
