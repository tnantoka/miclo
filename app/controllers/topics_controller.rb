class TopicsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_user, only: [:index, :show]
  before_action :set_topic, only: [:show, :destroy]
  authorize_resource

  def index
    @topics = @user.topics.active.page(params[:page])
  end

  def show
  end

  def destroy
    @topic.destroy!
    head :no_content
  end

  private

    def set_user
      @user = User.find_by!(username: params[:u_id]) if params[:u_id].present?
    end

    def set_topic
      @topic = if @user.present?
        @user.topics.find_by!(sequential_id: params[:id])
      else
        Topic.find(params[:id])
      end
    end
end
