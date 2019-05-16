require 'rails_helper'

describe 'On the home page' do
  context 'as a visitor' do
    it 'can see a list of only free tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial, classroom: true)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within('.tutorials') do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial2.title)
        expect(page).to_not have_content(tutorial3.title)
      end
    end
  end

  context 'as a registered user' do
    it 'can see a list of only free tutorials' do
      user = create(:user)
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial, classroom: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      expect(page).to have_css('.tutorial', count: 3)

      within('.tutorials') do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial2.title)
        expect(page).to have_content(tutorial3.title)
      end
    end
  end
end
