require 'rails_helper'

RSpec.describe 'as a admin on the home page' do
  context 'when I click on an empty tutorial' do
    it 'is taken to a new video path' do
      admin = create(:admin)
      tutorial = create(:tutorial)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(admin)

      visit tutorial_path(tutorial)

      click_link 'Add Video'

      fill_in 'video[title]', with: 'Test Video'
      fill_in 'video[description]', with: 'Description of video.'
      fill_in 'video[video_id]', with: 'PyHxTHN-kvU'
      click_on 'Create Video'

      expect(page).to have_content("#{Video.last.title} added to #{tutorial.title}")
      expect(Video.last.title).to eq('Test Video')
    end
  end
end