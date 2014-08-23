require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user_1) { User.create_with_auth_hash(mock_auth_hash) }
  let(:user_2) { User.create!(username: 'user_2') }

  let(:post_1) { user_1.posts.create!(content: content) }
  let(:post_2) { user_2.posts.create!(content: content) }

  let(:topic_1) { post_1.topic }
  let(:topic_2) { post_2.topic }

  let(:content) { 'content' }

  subject(:ability) { Ability.new(user_1) }
  it { should be_able_to(:manage, user_1) }
  it { should_not be_able_to(:manage, user_2) }

  it { should be_able_to(:manage, post_1) }
  it { should_not be_able_to(:manage, post_2) }

  it { should be_able_to(:manage, topic_1) }
  it { should_not be_able_to(:manage, topic_2) }

  it { should be_able_to(:create, user_1.posts.new(content: content, topic: topic_1)) }
  it { should_not be_able_to(:create, user_1.posts.new(content: content, topic: topic_2)) }
end
