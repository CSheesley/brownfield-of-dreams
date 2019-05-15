require 'rails_helper'

describe 'Tutorial Show Page' do
  context 'If there is a video associated with a tutorial' do
    it 'must have a position set - or an error message will be shown' do
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial_id: tutorial.id, position: 1)
      video_2 = create(:video, tutorial_id: tutorial.id,)

      expect(tutorial.videos.count).to eq(2)

      visit tutorial_path(tutorial.id)

      expect(page).to have_content("Video must have placement validation")
    end
  end
end
