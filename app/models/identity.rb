class Identity < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true, uniqueness: { scope: :provider }

  serialize :raw

  scope :github, -> { find_by(provider: 'github') }

  class << self
    def find_or_create_with_auth_hash(auth_hash)
      find_or_create_by(provider: auth_hash[:provider], uid: auth_hash[:uid]).tap do |identity|
        identity.update(raw: auth_hash)
      end
    end
  end

  def register_user
    (user.presence || User.create_with_auth_hash(raw)).tap do |user|
      user.update_with_auth_hash(raw)
      update(user: user)
    end
  end
end
