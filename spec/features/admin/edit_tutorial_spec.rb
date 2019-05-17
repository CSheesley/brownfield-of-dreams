require 'rails_helper'

describe 'An Admin can edit a tutorial' do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  scenario 'by adding a video', :js, :vcr do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(admin)

    visit tutorial_path(tutorial)
    
    visit edit_admin_tutorial_path(tutorial)
    
    click_on 'Add Video'

    fill_in 'video[title]', with: 'Test Video.'
    fill_in 'video[description]', with: 'Description of video.'
    fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
    click_on 'Create Video'

    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

    within(first('.video')) do
      expect(page).to have_content('Test Video.')
    end
  end
end
