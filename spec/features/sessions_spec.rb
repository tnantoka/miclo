require 'rails_helper'

feature 'Sessions', type: :feature do
  describe 'sign up' do
    before do
      sign_in
    end
    it 'redirects to home' do
      expect(page.current_path).to eq home_path
    end
    it 'shows signed_in message' do
      expect(page).to have_content I18n.t('flash.sessions.signed_in')
    end
  end

  describe 'sign in' do
    before do
      Identity.find_or_create_with_auth_hash(mock_auth_hash)
      sign_in
    end
    it 'redirects to home' do
      expect(page.current_path).to eq home_path
    end
    it 'shows signed_in message' do
      expect(page).to have_content I18n.t('flash.sessions.signed_in')
    end
  end

  describe 'sign out' do
    before do
      sign_in
      sign_out
    end
    it 'redirects to root' do
      expect(page.current_path).to eq root_path
    end
    it 'shows signed_out message' do
      expect(page).to have_content I18n.t('flash.sessions.signed_out')
    end
  end

  describe 'failure' do
    before do
      sign_in(:invalid_credentials)
    end
    it 'redirects to root' do
      expect(page.current_path).to eq root_path
    end
    it 'shows failure message' do
      expect(page).to have_content I18n.t('flash.sessions.failure', reason: :invalid_credentials)
    end
  end
end
