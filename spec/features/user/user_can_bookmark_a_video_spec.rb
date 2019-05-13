require 'rails_helper'

describe 'A registered user' do
  before :each do
    @tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    @video = create(:video, tutorial: @tutorial)
    @user = create(:user)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(@user)

    visit tutorial_path(@tutorial)
  end

  it 'can add videos to their bookmarks' do
    click_on 'Bookmark'

    expect(UserVideo.count).to eq(1)
    expect(UserVideo.first.video_id).to eq(@video.id)
    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    click_on 'Bookmark'

    expect(page).to have_content('Bookmark added to your dashboard')

    click_on 'Bookmark'

    expect(page).to have_content('Already in your bookmarks')
  end
end
