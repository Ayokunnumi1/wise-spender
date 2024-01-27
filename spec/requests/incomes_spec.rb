require 'rails_helper'

RSpec.describe "Incomes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/incomes/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/incomes/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/incomes/create"
      expect(response).to have_http_status(:success)
    end
  end

end
