require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:user) { User.create_with_auth_hash(mock_auth_hash) }
  let(:topic) { user.topics.create }

  describe '#to_param' do
    let(:sequential_id) { topic.sequential_id }
    subject { topic.to_param }
    it { should eq sequential_id }
  end

  describe '#newer' do
    let(:newer_topic) { topic.user.topics.create }
    subject { topic.newer }
    it { should eq newer_topic }
  end

  describe '#older' do
    let(:newer_topic) { topic.user.topics.create }
    subject { newer_topic.older }
    it { should eq topic }
  end
end
