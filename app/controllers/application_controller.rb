class ApplicationController < ActionController::Base
  include Pundit::Authorization

  MAX_RECORDS_PER_PAGE = 10

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_back fallback_location: root_path, notice: 'You\'re not allowed to perform this action.'
  end
end
