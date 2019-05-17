require 'rails_helper'

RSpec.describe 'as a visitor' do
  context 'on any tutorial show page' do
    it 'notifies me to register to see content' do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)

      visit tutorial_path(tutorial_1)
      
      expect(page).to have_content('Please log in to view this content')
      expect(page).to have_link("Log In")

      visit tutorial_path(tutorial_2)
      
      expect(page).to have_content('Please log in to view this content')

      click_link 'Log In'
      
      expect(current_path).to eq(login_path)
    end
  end
end