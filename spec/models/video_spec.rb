require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:position) }
  end

  describe 'class methods' do
    context '.set_missing_postions' do
      it 'will assign positions to videos where position is currently nil' do
        tutorial = create(:tutorial)
        video_1 = Video.create!(title: "Video 1", description: "A video", tutorial_id: tutorial.id, position: 1)
        video_2 = Video.create!(title: "Video 2", description: "Other video", tutorial_id: tutorial.id, position: nil)
        video_3 = Video.create!(title: "Video 3", description: "Another video", tutorial_id: tutorial.id, position: nil)

        expect(video_2.position).to eq(nil)
        expect(video_3.position).to eq(nil)
        # force create an object despite validation
        Video.set_missing_postions

        expect(video_2.position).to eq(2)
        expect(video_3.position).to eq(3)
      end
    end
  end

end
