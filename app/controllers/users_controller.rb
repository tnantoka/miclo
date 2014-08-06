class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  authorize_resource

  def show
    @topics = @user.topics.active.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      reload_current_user
      redirect_to :edit_user, notice: t('flash.shared.updated', target: t('shared.account'))
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!
    reset_session
    redirect_to :root, notice: t('flash.shared.destroyed', target: t('shared.account'))
  end

  private
    def set_user
      # Don't use current_user to avoid showing invalid content on navbar etc.
      @user = if action_name == 'show'
        User.find_by!(username: params[:id])
      else
        User.find(current_user.id)
      end
    end

    def user_params
      params.require(:user).permit(:username, :locale)
    end
end
