# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notifications', type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:another_user_article) { create(:article, user: another_user) }
  let(:comment_to_another_user_article) { create(:comment, user:, article: another_user_article) }
  let(:notification) { create(:notification, :for_article) }

  let(:valid_comment_attributes) do
    { body: 'Updated body' }
  end
  let(:invalid_comment_attributes) do
    { body: '' }
  end

  before { sign_in user }

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete notification_path(notification)
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE /destroy_all' do
    it 'returns http success' do
      delete destroy_all_notifications_path
      expect(response).to have_http_status(:found)
    end
  end

end
