# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Reactions", type: :request do
  let(:user) { create(:user) }
  let(:article) { create(:article, user:) }

  let(:valid_reaction_attributes) do
    { status: :liked, user:, reactionable: article }
  end
  let(:invalid_reaction_attributes) do
    { status: '' }
  end

  before { sign_in user }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Reaction" do
        expect {
          post article_reactions_url(article), params: { reaction: valid_reaction_attributes }
        }.to change(Reaction, :count).by(1)
      end

      it "redirects to its reactionable record" do
        post article_reactions_url(article), params: { reaction: valid_reaction_attributes }
        expect(response).to redirect_to(article_url(article))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Reaction" do
        expect {
          post article_reactions_url(article), params: { reaction: invalid_reaction_attributes }
        }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested reaction" do
      reaction = Reaction.create! valid_reaction_attributes
      expect {
        delete reaction_url(reaction)
      }.to change(Reaction, :count).by(-1)
    end
  end
end
