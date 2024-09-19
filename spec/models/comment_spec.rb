# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { described_class.new(comment_attributes) }

  let(:comment_attributes) { { body:, user_id:, article_id: } }
  let(:body) { 'Foo' }
  let(:user_id) { user.id }
  let(:user) { User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password') }
  let(:article_id) { article.id }
  let(:article) { Article.create!(title: 'foo', body: 'bar', user_id:) }

  describe 'comment validity' do
    subject(:comment_validity) { comment.valid? }

    context 'when the comment has all attributes set with valid values' do
      it { is_expected.to be true }
    end

    context 'when the comment is blank' do
      let(:body) { nil }

      it { is_expected.to be false }
    end
  end
end
