require 'rails_helper'

RSpec.describe "Flashes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/flashes/index"
      expect(response).to have_http_status(:success)
    end
  end

end
