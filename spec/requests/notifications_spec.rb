require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "GET /destroy" do
    it "returns http success" do
      get "/notifications/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy_all" do
    it "returns http success" do
      get "/notifications/destroy_all"
      expect(response).to have_http_status(:success)
    end
  end

end
