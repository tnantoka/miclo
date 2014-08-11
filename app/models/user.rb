class User < ActiveRecord::Base
  enum locale: %i(en ja)

  has_many :identities, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :queries, dependent: :destroy

  acts_as_tagger

  module ImageSize
    Default = 48
  end

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { maximum: 64 },
    format: { with: /\A[\w\-]+\z/ }

  class << self
    def create_with_auth_hash(auth_hash)
      info = auth_hash[:info]
      nickname = info[:nickname].presence || info[:name] # name for developer strategy
      create(username: generate_unique_username(nickname), image: info[:image], locale: I18n.locale)
    end

    def generate_unique_username(nickname)
      username = nickname.parameterize
      suffix = 2
      while User.exists?(username: username) do
        username = "#{nickname}_#{suffix}"
        suffix += 1
      end
      username
    end
  end

  def update_with_auth_hash(auth_hash)
    update(image: auth_hash[:info][:image])
  end

  def default_image
    resized_image(ImageSize::Default)
  end

  def to_param
    username
  end

  def nickname(provider)
    identity = identities.send(provider).last
    identity.raw[:info][:nickname] if identity.present?
  end

  private
    def resized_image(size)
      "#{image}&s=#{size}"
    end
end
