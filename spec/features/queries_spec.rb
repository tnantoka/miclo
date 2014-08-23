require 'rails_helper'

feature 'Queries', type: :feature do
  let(:user) { User.first }
  let(:content_1) { "content_1 #{query_1}" }
  let(:query_1) { 'query_1' }
  let(:content_2) { "content_2 #{query_2}" }
  let(:query_2) { 'query_2' }

  before do
    sign_in
    user.posts.create(content: content_1)
    user.posts.create(content: content_2)
  end

  context 'without js' do
    describe 'show' do
      before do
        visit search_path(q: { posts_content_cont: query_1 })
        visit search_path(q: { posts_content_cont: query_2 })
        visit queries_path(format: :json)
      end
      it 'shows queries' do
        expect(page).to have_content(query_1)
        expect(page).to have_content(query_2)
      end
    end
  end

  context 'with js', js: true do
    describe 'show' do
      before do
        visit search_path(q: { posts_content_cont: "#{query_1} #{query_2}" })
      end
      it 'shows matched topics' do
        expect(page).to have_content(content_1)
        expect(page).to have_content(content_2)
      end
    end
  end
end
