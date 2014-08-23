class QueriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    q = split_search_query(params)
    @search = Topic.search(q)
    @topics = @search.result(distinct: true).active.page(params[:page])
    @user = User.find_by(id: q[:user_id_eq])

    respond_to do |format|
      format.html {}
      format.json { render 'topics/index' }
    end
  end

  def index
    @queries = current_user.queries.active.page(params[:page])
  end

  private

    def split_search_query(params)
      (params[:q].presence || {}).dup.tap do |q|
        convert_content_cont(q)
        verify_user_id_eq(q)
      end
    end

    def convert_content_cont(q)
      return unless q[:posts_content_cont].present?

      cont = q.delete(:posts_content_cont)
      q[:posts_content_cont_any] = cont.split(/\p{blank}+/)
      current_user.queries.find_or_create_by(text: cont).touch if user_signed_in?
    end

    def verify_user_id_eq(q)
      return unless q[:user_id_eq].to_i.zero?

      q.delete(:user_id_eq)
    end
end
