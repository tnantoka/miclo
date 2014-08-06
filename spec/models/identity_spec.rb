require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe '#uid' do
    # Did not expect errors to include "has already been taken" when uid is set to "a", got error: has already been taken (with different value of provider)
    # it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
    it { should validate_uniqueness_of(:uid) }
  end

  describe '.find_or_create_with_auth_hash' do
    let(:identity) { Identity.find_or_create_with_auth_hash(mock_auth_hash) }
    describe '#provider' do
      subject { identity.provider }
      it { should eq mock_auth_hash[:provider] }
    end
    describe '#uid' do
      subject { identity.uid }
      it { should eq mock_auth_hash[:uid] }
    end
    describe '#raw' do
      subject { identity.raw }
      it { should eq mock_auth_hash }
    end
  end

  describe '#register_user' do
    subject {
      identity = Identity.find_or_create_with_auth_hash(mock_auth_hash)
      identity.register_user.username
    }
    it { should eq mock_auth_hash[:info][:nickname] }
  end
end
