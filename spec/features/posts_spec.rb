require 'rails_helper'

feature 'Posts', type: :feature do
  let(:user) { User.first }

  before do
    sign_in
  end

  context 'with js', js: true do
    let(:post) { user.posts.create(content: content) }

    context 'when user is signed in' do
      describe 'show' do
        let(:content) { '# content' }
        let(:content_text) { 'content' }
        context 'when format is html' do
          before do
            visit u_t_p_path(user, post.topic, post)
          end
          it 'shows rendered content' do
            expect(page).to have_content(content_text)
          end
        end
        context 'when format is md' do
          before do
            visit u_t_p_path(user, post.topic, post, format: :md)
          end
          it 'shows raw content' do
            expect(page).to have_content(content)
          end
        end
      end

      describe 'create' do
        before do
          visit home_path
          find("[title='#{I18n.t('shared.new_post')}']").click
          within '.modal.in' do
            fill_in 'post[content]', with: content
            click_on I18n.t('shared.post')
          end
        end

        context 'when post is valid' do
          let(:content) { 'content' }
          it 'creates post' do
            expect(page).to have_content(content)
          end
          # FIXME: sometimes fail on Travis CI
          #it 'shows created message' do
          #  expect(page).to have_content(I18n.t('flash.shared.created', target: I18n.t('activerecord.models.post')))
          #end
        end

        context 'when post is invalid' do
          let(:content) { '' }
          it 'shows blank message' do
            expect(page).to have_content(I18n.t('errors.messages.blank'))
          end
        end
      end

      describe 'update' do
        let(:post) { user.posts.create(content: content) }
        let(:content) { 'content' }

        before do
          post
          visit home_path
          find("a[title='#{I18n.t('shared.edit_post')}']").click
          within '.modal.in' do
            fill_in 'post[content]', with: updated_content
            click_on I18n.t('shared.update')
          end
        end

        context 'when post is valid' do
          let(:updated_content) { 'updated_content' }
          it 'updates post' do
            expect(page).to have_content(updated_content)
          end
          #it 'shows updated message' do
          #  expect(page).to have_content(I18n.t('flash.shared.updated', target: I18n.t('activerecord.models.post')))
          #end
        end

        context 'when post is invalid' do
          let(:updated_content) { '' }
          it 'shows blank message' do
            expect(page).to have_content(I18n.t('errors.messages.blank'))
          end
        end
      end

      describe 'destroy' do
        let(:content) { 'content' }
        before do
          post
          visit home_path
          find("a[href='#{post_path(post.id)}'][data-method='delete']").click
        end
        it 'destroys post' do
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
          visit u_t_p_path(user, post.topic, post)
        end
        it 'shows rendered content' do
          expect(page).to have_content(content_text)
        end
      end
    end
  end
end
