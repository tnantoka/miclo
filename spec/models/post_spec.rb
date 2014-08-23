require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create_with_auth_hash(mock_auth_hash) }
  let(:post) { user.posts.create(content: content) }

  describe '#content' do
    it { should validate_presence_of(:content) }
  end

  describe '#to_param' do
    let(:content) { 'content' }
    let(:sequential_id) { post.sequential_id }
    subject { post.to_param }
    it { should eq sequential_id }
  end

  describe '#create_topic' do
    let(:content) { 'content' }
    subject { post.topic }
    it { should be_present }
  end

  describe '#destroy_topic' do
    let(:content) { 'content' }
    let(:topic_id) { post.topic.id }
    subject {
      post.destroy
      Topic.exists?(topic_id)
    }
    it { should be_falsey }
  end

  describe '#tag_list' do
    let(:content) { '#foo #bar' }
    subject { post.tag_list }
    it { should eq %w(#foo #bar) }
  end

  describe '#newer' do
    let(:content) { 'content' }
    let(:newer_post) { user.posts.create!(content: content, topic: post.topic) }
    subject { post.newer }
    it { should eq newer_post }
  end

  describe '#older' do
    let(:content) { 'content' }
    let(:newer_post) { user.posts.create!(content: content, topic: post.topic) }
    subject { newer_post.older }
    it { should eq post }
  end

  describe '#render' do
    let(:content) {
      <<-EOD.strip_heredoc
        content
        # header #hashtag
        #hashtag
        http://example.com/#acnhor
        [Example](http://example.com/#acnhor)
      EOD
    }
    let(:content_html) {
      hashtag = %(<a href="/search?q%5Bposts_content_cont%5D=%23hashtag&amp;q%5Buser_id_eq%5D=#{user.id}">#hashtag</a>)
      <<-EOD.strip_heredoc
        <p>content</p>

        <h1>header #{hashtag}
        </h1>

        <p>#{hashtag}<br>
        <a href="http://example.com/#acnhor" target="_blank">http://example.com/#acnhor</a><br>
        <a href="http://example.com/#acnhor" target="_blank">Example</a></p>
      EOD
    }
    subject { post.render }
    it { should eq content_html }
  end
end
