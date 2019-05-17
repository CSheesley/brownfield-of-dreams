require 'rails_helper'

RSpec.describe 'as a logged in user on a tutorial show page' do
  context 'for a tutorial with no videos' do
    it 'it notifies me that there are no videos' do

      user = create(:user)
      tutorial = create(:tutorial)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit tutorial_path(tutorial)

      expect(tutorial.videos.empty?).to eq(true)
      
      expect(page).to have_content('There are currently no videos for this tutorial.')
    end
  end
end