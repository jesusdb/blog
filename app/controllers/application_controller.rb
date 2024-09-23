# frozen_string_literal: true

require 'will_paginate/array'

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :set_current_user_notifications, if: :user_signed_in?
  before_action :fetch_external_articles

  MAX_RECORDS_PER_PAGE = 5

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_back fallback_location: root_path, notice: 'You\'re not allowed to perform this action.'
  end

  private

  def fetch_external_articles
    cache_key = "related_articles_for_#{params[:query] || 'blank'}"

    Rails.cache.fetch(cache_key, expires_in: 24.hours) do
      @external_articles = NewsApiClient.new
                                        .fetch_related_articles(query: params[:query])
                                        .paginate(page: params[:page], per_page: MAX_RECORDS_PER_PAGE)
    end
  end

  def set_current_user_notifications
    @notifications = current_user.notifications
  end
end
