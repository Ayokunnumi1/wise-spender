# spec/controllers/categories_controller_spec.rb
require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  include Devise::Test::ControllerHelpers
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :index
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not authenticated' do
      before do
        get :index
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #new' do
    context 'when user is authenticated' do
      before do
        sign_in user
        get :new
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end
    end

    context 'when user is not authenticated' do
      before do
        get :new
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before do
        sign_in user
        post :create, params: { category: { name: 'New Category', icon: 'new_icon' } }
      end

      it 'creates a new category and redirects to index' do
        expect(response).to redirect_to(categories_path)
        expect(flash[:success]).to eq('Category Saved Successfully')
      end
    end

    context 'when user is not authenticated' do
      before do
        post :create, params: { category: { name: 'New Category', icon: 'new_icon' } }
      end

      it 'redirects to sign in' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end