require 'rails_helper'

feature 'Hashtags', type: :feature do
  let(:user) { User.first }
  let(:content) { "#{tag_1} #{tag_2}" }
  let(:tag_1) { '#tag_1' }
  let(:tag_2) { '#tag_2' }

  before do
    sign_in
    user.posts.create(content: content)
  end

  describe 'index' do
    before do
      visit hashtags_path(format: :json)
    end
    it 'shows queries' do
      expect(page).to have_content(tag_1)
      expect(page).to have_content(tag_2)
    end
  end
end
