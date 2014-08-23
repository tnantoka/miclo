require 'rails_helper'

feature 'Topics', type: :feature do
  let(:user) { User.first }

  before do
    sign_in
  end

  context 'with js', js: true do
    let(:post) { user.posts.create(content: content) }
    let(:topic) { post.topic }

    context 'when user is signed in' do
      describe 'show' do
        let(:content) { '# content' }
        let(:content_text) { 'content' }
        context 'when format is html' do
          before do
            visit u_t_path(user, topic)
          end
          it 'shows topic' do
            expect(page).to have_content(content_text)
          end
        end
        context 'when format is md' do
          before do
            visit u_t_path(user, topic, format: :md)
          end
          it 'shows raw content' do
            expect(page).to have_content(content)
          end
        end
      end

      describe 'index' do
        let(:content) { 'content' }
        before do
          visit u_t_index_path(user, topic)
        end
        it 'shows topics' do
          expect(page).to have_content(content)
        end
      end

      describe 'destroy' do
        let(:content) { 'content' }
        before do
          topic
          visit home_path
          find("a[href='#{topic_path(topic.id)}'][data-method='delete']").click
        end
        it 'destroys topic' do
          expect(page).to_not have_content(content)
        end
      end
    end

    context 'when user is signed out' do
      before do
        sign_out
      end

      describe 'show' do
        let(:content) { '# content' }
        let(:content_text) { 'content' }

        before do
          visit u_t_path(user, topic)
        end
        it 'shows topic' do
          expect(page).to have_content(content_text)
        end
      end

      describe 'index' do
        let(:content) { 'content' }
        before do
          visit u_t_index_path(user, topic)
        end
        it 'shows topics' do
          expect(page).to have_content(content)
        end
      end
    end
  end
end
