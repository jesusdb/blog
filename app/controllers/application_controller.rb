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
    conn = Faraday.new(url: 'https://newsapi.org/v2/', params: { 'apiKey' => ENV.fetch('NEWS_API_API_KEY') })
    response = conn.get('everything') do |req|
      req.params['q'] = 'Apple'
      req.params['from'] = Time.now.yesterday.strftime('%F')
      req.params['sortBy'] = 'popularity'
    end
    @external_articles = JSON.parse(response.body)['articles'].first(5)
  end

  def set_current_user_notifications
    @notifications = current_user.notifications
  end
end
