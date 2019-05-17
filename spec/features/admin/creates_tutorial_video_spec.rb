require 'rails_helper'

RSpec.describe 'as a admin on the home page' do
  context 'when I click on an empty tutorial' do
    it 'is taken to a new video path' do
      admin = create(:admin)
      tutorial = create(:tutorial)
      # video = create(:video)
      # require 'pry'; binding.pry

      visit '/'

      click_on tutorial.title

      expect(current_path).to eq(admin_new_tutorial_video_path)
      expect(Video.count).to eq(0)
      
      fill_in 'title', with: 'video_title'
      fill_in 'description', with: 'description'
      fill_in 'thumbnail', with: 'thumbnail'
      fill_in 'description', with: 'description'
      #fill in video id?
      fill_in 'video_id', with: '1234'
      #expect to be associated with tutorial

      click_button 'Create Video'
      expect(Video.count).to eq(1)

      expect(page).to have_content("Successfully video_title added title to #{tutuorial.title}")
    end
  end
end