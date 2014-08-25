class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    redirect_to :home, notice: flash[:notice], alert: flash[:alert] if user_signed_in?
  end

  def home
    @post = current_user.posts.build
    @topics = current_user.topics.active.page(params[:page])
    @user = current_user
  end
end
