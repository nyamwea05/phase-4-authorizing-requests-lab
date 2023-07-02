class MembersOnlyArticlesController < ApplicationController
  before_action :authenticate_user!

  def index
    articles = Article.where(is_member_only: true)
    render json: articles
  end

  def show
    article = Article.find(params[:id])

    if article.is_member_only?
      render json: article
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def authenticate_user!
    unless current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
