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
        video_1 = Video.create(title: "Video 1", description: "A video", tutorial_id: tutorial.id, position: 1)
        video_2 = Video.new(title: "Video 2", description: "Other video", tutorial_id: tutorial.id, position: nil)
        video_3 = Video.new(title: "Video 3", description: "Another video", tutorial_id: tutorial.id, position: nil)

        # Ignores validations to assume that we had videos in the DB with position: nil
        video_2.save(validate: false)
        video_3.save(validate: false)

        expect(video_2.position).to eq(nil)
        expect(video_3.position).to eq(nil)

        Video.set_missing_postions

        video_2.reload
        video_3.reload

        expect(video_2.position).to eq(2)
        expect(video_3.position).to eq(3)
      end
    end
  end
end
