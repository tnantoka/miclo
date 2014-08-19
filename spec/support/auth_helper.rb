module AuthHelper
  def mock_auth_hash
    OmniAuth::AuthHash.new({
      uid: 1,
      provider: :github,
      info: {
        nickname: 'nickname',
        image: 'image',
      }
    })
  end

  def sign_in(auth_hash = mock_auth_hash)
    page.driver.headers = { 'Accept-Language' => 'en' }  if page.driver.respond_to?(:headers=)

    provider = mock_auth_hash[:provider]

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[provider] = auth_hash

    visit root_path
    click_on I18n.t('shared.sign_in')
  end

  def sign_out
    all('.navbar-fixed-top .dropdown-toggle').last.click
    click_on I18n.t('shared.sign_out')
  end

  def current_user(auth_hash = mock_auth_hash)
    Identity.find_by(uid: auth_hash[:uid], provider: auth_hash[:provider]).try(:user)
  end
end
