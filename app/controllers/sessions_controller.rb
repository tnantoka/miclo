class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :failure]
  skip_before_action :verify_authenticity_token, if: -> { Rails.env.development? }

  def create
    @identity = Identity.find_or_create_with_auth_hash(auth_hash)
    self.current_user = @identity.register_user
    redirect_to :home, notice: t('flash.sessions.signed_in')
  end

  def destroy
    self.current_user = nil
    redirect_to :root, notice: t('flash.sessions.signed_out')
  end

  def failure
    redirect_to :root, alert: t('flash.sessions.failure', reason: params[:message])
  end

  protected

    def auth_hash
      request.env['omniauth.auth']
    end
end
