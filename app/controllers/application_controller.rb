class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current_user_notifications, if: :user_signed_in?
  before_action :fetch_external_articles

  MAX_RECORDS_PER_PAGE = 10

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_back fallback_location: root_path, notice: 'You\'re not allowed to perform this action.'
  end

  private

  def fetch_external_articles
    @external_articles = NewsApiClient.new.fetch_related_articles(query: params[:query])
  end

  def set_current_user_notifications
    @notifications = current_user.notifications
  end
end
