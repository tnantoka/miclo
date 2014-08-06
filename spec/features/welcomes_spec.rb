require 'rails_helper'

feature "Welcomes", type: :feature do
  context 'signed out' do
    describe 'home' do
      before do
        visit home_path
      end
      it 'redirects to root' do
        expect(page.current_path).to eq root_path
      end
      it 'shows unauthenticated message' do
        expect(page).to have_content I18n.t('flash.shared.unauthenticated')
      end
    end
  end
end
