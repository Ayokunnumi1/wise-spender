# spec/controllers/incomes_controller_spec.rb
require 'rails_helper'

RSpec.describe IncomesController, type: :controller do
  include Devise::Test::ControllerHelpers
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }
  let(:income) { create(:income, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new income' do
      get :new
      expect(assigns(:income)).to be_a_new(Income)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new income' do
        expect {
          post :create, params: { income: attributes_for(:income) }
        }.to change(Income, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new income' do
        expect {
          post :create, params: { income: attributes_for(:income, amount: nil) }
        }.not_to change(Income, :count)
      end
    end
  end

  describe 'DELETE #clear_all' do
    it 'deletes all incomes' do
      income
      expect {
        delete :clear_all
      }.to change(Income, :count).by(-1)
    end
  end
end