# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:article) { create(:article, user:) }
  let(:another_user_article) { create(:article, user: another_user) }

  context "when the user is not an admin" do
    before { sign_in user }

    it "allows a user to edit their own article" do
      get edit_article_path(article)
      expect(response).to have_http_status(:success)
    end

    it "does not allow a user to edit someone else's article" do
      get edit_article_path(other_user_article)
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("You are not authorized to perform this action.")
    end
  end

  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
end
