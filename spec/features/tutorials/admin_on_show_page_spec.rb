require 'rails_helper'

RSpec.describe 'as a admin on a tutorial show page' do
  context 'for a tutorial with no videos' do
    it 'shows a link to add a new video' do
      admin = create(:admin)
      tutorial = create(:tutorial)

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(admin)

      visit tutorial_path(tutorial)

      expect(tutorial.videos.empty?).to eq(true)
      
      click_link 'Add Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial.id))

      fill_in 'video[title]', with: 'Test Video'
      fill_in 'video[description]', with: 'Description of video.'
      fill_in 'video[video_id]', with: 'qMkRHW9zE1c'
      click_on 'Create Video'

      new_video = Video.last
      expect(new_video.title).to eq('Test Video')
      expect(page).to have_content("#{new_video.title} added to #{tutorial.title}")
      expect(tutorial.videos.empty?).to eq(false)
    end
  end
end