require 'rails_helper'

RSpec.describe 'as a user on the tutorial show page' do
  context 'it clicks on a tutorial with no videos' do
    it 'can add a new video to that tutorial' do
      tutorial_1 = create(:tutorial)

      visit tutorial_path(tutorial_1)

      expect(path).to eq(new_tutorial_video_path)
    end
  end
end