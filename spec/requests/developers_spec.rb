require 'rails_helper'

RSpec.describe "Developers", type: :request do
  before { with_signed_in_user }
  describe "GET /index" do
    it "returns http success" do
      get "/developers"
      expect(response).to have_http_status(:success)
    end
  end
end
