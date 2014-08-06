class HashtagsController < ApplicationController
  def index
    @hashtags = current_user.owned_tags.order(name: :asc).page(params[:page]).per(30)
  end
end
