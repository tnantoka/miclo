class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show]
  before_action :set_topic, only: [:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    authorize! :manage, @post.topic if @post.topic.present?
    if @post.save
      @messages = [t('flash.shared.created', target: t('activerecord.models.post'))]
    else
      @messages = @post.errors.full_messages
      render status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      @messages = [t('flash.shared.updated', target: t('activerecord.models.post'))]
      render :create
    else
      @messages = @post.errors.full_messages
      render :create, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!
    head :no_content
  end

  def preview
    @content_html = current_user.posts.new(post_params).render
  end

  private
    def set_user
      @user = User.find_by!(username: params[:u_id]) if params[:u_id].present?
    end

    def set_topic
      @topic = @user.topics.find_by!(sequential_id: params[:t_id]) if @user.present?
    end

    def set_post
      @post = if @topic.present?
        @topic.posts.find_by!(sequential_id: params[:id])
      else
        Post.find(params[:id])
      end
    end

    def post_params
      params.require(:post).permit(:topic_id, :content)
    end
end
