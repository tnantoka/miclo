require 'rails_helper'

feature "Users", type: :feature do
  before do
    sign_in
  end

  describe 'show' do
    let(:user) { User.first }
    before do
      visit u_path(user)
    end
    it 'shows user profile' do
      expect(page).to have_content user.username
    end
  end
 
  describe 'update' do
    let(:locale) { 'ja' }
    before do
      visit edit_user_path
      fill_in 'user[username]', with: username
      select I18n.t("enum.locale.#{locale}")
      click_on 'Update'
    end
    context 'when user is valid' do
      let(:username) { 'a' }
      it 'redirects to edit_user' do
        expect(page.current_path).to eq edit_user_path
      end
      it 'shows updated message' do
        expect(page).to have_content I18n.t('flash.shared.updated', target: I18n.t('shared.account'))
      end
      it 'updates current_user#username' do
        expect(current_user.username).to eq username
      end
      it 'updates current_user#locale' do
        expect(current_user.locale).to eq locale
      end
    end
    context 'when user is invalid' do
      let(:username) { '.' }
      it 'doet not redirect' do
        expect(page.current_path).to eq user_path
      end
      it 'shows invalid message' do
        expect(page).to have_content(I18n.t('errors.messages.invalid'))
      end
      it 'does not update current_user#username' do
        expect(current_user.username).to_not eq username
      end
      it 'does not update current_user#locale' do
        expect(current_user.locale).to_not eq locale
      end
    end
  end

  describe 'destroy' do
    let(:locale) { 'ja' }
    before do
      visit edit_user_path
      click_on I18n.t('users.edit.delete')
    end
    it 'redirects to root' do
      expect(page.current_path).to eq root_path
    end
    it 'shows destroyed message' do
      expect(page).to have_content I18n.t('flash.shared.destroyed', target: I18n.t('shared.account'))
    end
    it 'destroys current_user' do
      expect(current_user).to eq nil
    end
  end
end
