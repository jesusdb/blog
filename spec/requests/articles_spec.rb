# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:article) { create(:article, user:) }
  let(:another_user_article) { create(:article, user: another_user) }

  let(:valid_article_attributes) do
    { title: 'Updated Title', body: 'Updated body' }
  end
  let(:invalid_article_attributes) do
    { title: '', body: '' }
  end

  include_context 'mock News API request'

  before do
    allow(Faraday).to receive(:new).and_return conn
  end

  after do
    Faraday.default_connection = nil
  end

  context 'when the user is not an admin' do
    before { sign_in user }

    describe 'GET /articles/:id/edit' do
      it 'allows the user to edit their own article' do
        get edit_article_path(article)
        expect(response).to have_http_status(:success)
      end

      it 'does not allow a user to edit someone else\'s article' do
        get edit_article_path(another_user_article)
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'POST /articles' do
      it 'returns http ok' do
        post articles_path, params: { article: valid_article_attributes }

        follow_redirect!
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'PATCH /articles/:id' do
      context 'when the user tries to update their own article' do
        before { patch article_path(article), params: { article: valid_article_attributes } }
        
        it 'redirects to article_path' do
          expect(response).to redirect_to(article_path(article))
          follow_redirect!
          expect(response.body).to include('Article was successfully updated.')
        end

        it 'updates the article correctly' do
          article.reload
          expect(article.title).to eq('Updated Title')
          expect(article.body).to eq('Updated body')
        end
      end

      context 'when the user tries to update someone else\'s article' do
        before { patch article_path(another_user_article) }

        it { expect(response).to redirect_to(root_path) }
        it 'does not update the article' do
          expect { article.reload }.not_to change(article, :updated_at)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'returns http see_other' do
        delete article_path(article)
        expect(response).to have_http_status(:see_other)
      end
    end
  end

  context 'when the user is an admin' do
    before do
      sign_in admin
    end

    it 'allows the admin to edit any article' do
      get edit_article_path(another_user_article)
      expect(response).to have_http_status(:success)
    end
  end

  context 'when the user is not signed in' do
    it 'redirects to the sign in page' do
      get edit_article_path(article)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
