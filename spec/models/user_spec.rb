require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create_with_auth_hash(mock_auth_hash) }

  describe '#username' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should ensure_length_of(:username).is_at_most(64) }
    it { should allow_value('aA0_-').for(:username) }
    it { should_not allow_value('.', ' ').for(:username) }
  end

  describe '#to_param' do
    let(:username) { user.username }
    subject { user.to_param }
    it { should eq username }
  end

  describe '#default_image' do
    let(:image) { user.image }
    subject { user.default_image }
    it { should eq "#{image}&s=#{User::ImageSize::DEFAULT}" }
  end

  describe '.create_with_auth_hash' do
    describe '#username' do
      subject { user.username }
      it { should eq mock_auth_hash[:info][:nickname] }
    end
    describe '#image' do
      subject { user.image }
      it { should eq mock_auth_hash[:info][:image] }
    end
    describe '#locale' do
      subject { user.locale }
      it { should eq I18n.locale.to_s }
    end
  end

  describe '.generate_unique_username(nickname)' do
    subject {
      2.times { User.create_with_auth_hash(mock_auth_hash) }
      User.last.username
    }
    it { should eq "#{mock_auth_hash[:info][:nickname]}_2" }
  end
end
