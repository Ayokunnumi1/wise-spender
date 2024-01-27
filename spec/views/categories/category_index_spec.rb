# spec/requests/categories_request_spec.rb
require 'rails_helper'

RSpec.describe "Categories", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    User.create!(name: 'John Doe', email: 'sample@gmail.com', password: 'password', confirmed_at: Time.zone.now)
  end

  let(:category) { Category.create!(name: 'Journey', icon: Category::ICONS.keys.first, user: user) }

  before do
    login_as(user, scope: :user)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get categories_path

      expect(response).to have_http_status(:success)
    end

    it 'renders the correct view' do
      get categories_path

      expect(response.body).to include('CATEGORIES')
      expect(response.body).to include('Balance:')
      expect(response.body).to include('Expenses:')
      expect(response.body).to include('Income:')
      expect(response.body).to include('➕ Add Income')
      expect(response.body).to include('➖ Reset Income')
      expect(response.body).to include('Add New Category')
    end
  end
end