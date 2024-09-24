# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  subject(:article) { described_class.new(article_attributes) }

  let(:article_attributes) { { title:, body:, user_id: } }
  let(:title) { 'Foo' }
  let(:body) { 'Bar' }
  let(:user_id) { user.id }
  let(:user) { User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password') }

  describe 'article validity' do
    subject(:article_validity) { article.valid? }

    context 'when the article has all attributes set with valid values' do
      it { is_expected.to be true }
    end

    context 'when the article has no title' do
      let(:title) { nil }

      it { is_expected.to be false }
    end

    context 'when the article has no body' do
      let(:body) { nil }

      it { is_expected.to be false }
    end
  end

  describe '.search' do
    subject(:result) { described_class.search(query) }

    let(:query) { 'sports' }

    
  end
end
