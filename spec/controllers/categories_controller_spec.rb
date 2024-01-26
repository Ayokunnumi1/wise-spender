# spec/controllers/categories_controller_spec.rb
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers
  include Devise::Test::IntegrationHelpers
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user, confirmed_at: Time.zone.now) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      it 'renders the index template' do
        sign_in user

        get :index

        expect(response).to render_template(:index)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :index

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when user is authenticated' do
      it 'renders the new template' do
        sign_in user

        get :new

        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      it 'creates a new category and redirects to index' do
        sign_in user

        post :create, params: { category: { name: 'New Category', icon: 'new_icon' } }

        expect(response).to redirect_to(categories_path)
        expect(flash[:success]).to eq('Category Saved Successfully')
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to sign in' do
        post :create, params: { category: { name: 'New Category', icon: 'new_icon' } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end