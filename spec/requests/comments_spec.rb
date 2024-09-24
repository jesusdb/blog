# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:comment) { create(:comment, user:) }
  let(:another_user_comment) { create(:comment, user: another_user) }

  let(:valid_comment_attributes) do
    { body: 'Updated body' }
  end
  let(:invalid_comment_attributes) do
    { body: '' }
  end

  include_context 'mock News API request'

  before do
    allow(Faraday).to receive(:new).and_return conn
  end

  context 'when the user is not an admin' do
    before { sign_in user }

    describe 'GET /comments/:id/edit' do
      it 'allows the user to edit their own comment' do
        get edit_comment_path(comment)
        expect(response).to have_http_status(:success)
      end

      it 'does not allow a user to edit someone else\'s comment' do
        get edit_comment_path(another_user_comment)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'PATCH /comments/:id' do
      context 'when the user tries to update their own comment' do
        before { patch comment_path(comment), params: { comment: valid_comment_attributes } }
        
        it 'redirects to comment_path' do
          expect(response).to redirect_to(article_path(comment.article))
        end

        it 'updates the comment correctly' do
          comment.reload
          expect(comment.body).to eq('Updated body')
        end
      end

      context 'when the user tries to update someone else\'s comment' do
        before { patch comment_path(another_user_comment) }

        it { expect(response).to redirect_to(root_path) }
        it 'does not update the comment' do
          expect { comment.reload }.not_to change(comment, :updated_at)
        end
      end
    end
  end

  context 'when the user is an admin' do
    before do
      sign_in admin
    end

    it 'allows the admin to edit any comment' do
      get edit_comment_path(another_user_comment)
      expect(response).to have_http_status(:success)
    end
  end

  context 'when the user is not signed in' do
    it 'redirects to the sign in page' do
      get edit_comment_path(comment)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
