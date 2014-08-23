class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :authenticate_user!
  before_action :set_search

  def set_locale
    I18n.locale = extract_locale_from_params ||
      current_user.try(:locale).presence ||
      extract_locale_from_accept_language_header ||
      I18n.default_locale
  end

  def set_search
    @search = Topic.search(nil) if params[:q].nil?
  end

  def default_url_options(options = {})
    { locale: params[:locale] }
  end

  protected

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
    helper_method :current_user

    def user_signed_in?
      !!current_user
    end
    helper_method :user_signed_in?

    def current_user=(user)
      @current_user = user
      session[:user_id] = user.try(:id)
    end

    def authenticate_user!
      return if user_signed_in?

      redirect_to :root, alert: t('flash.shared.unauthenticated')
    end

    def reload_current_user
      current_user.reload
      set_locale
    end

  private

    def extract_locale_from_accept_language_header
      available_locale(request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).first)
    end

    def extract_locale_from_params
      available_locale(params[:locale])
    end

    def available_locale(parsed_locale)
      I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
    end
end
