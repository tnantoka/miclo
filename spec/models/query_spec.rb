require 'rails_helper'

RSpec.describe Query, type: :model do
  describe '#text' do
    it { should validate_uniqueness_of(:text).scoped_to(:user_id) }
  end
end
