# spec/controllers/expenses_controller_spec.rb
require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include Devise::Test::ControllerHelpers
  include FactoryBot::Syntax::Methods

  let(:user) { create(:user) }
  let(:category) { create(:category, user:) }
  let(:expense) { create(:expense, author: user, category:) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'assigns a new expense' do
      get :new, params: { category_id: category.id }
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new expense' do
        expect do
          post :create, params: { expense: attributes_for(:expense, category_id: category.id) }
        end.to change(Expense, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new expense' do
        expect do
          post :create, params: { expense: attributes_for(:expense, name: nil, category_id: category.id) }
        end.not_to change(Expense, :count)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested expense to @expense' do
      get :edit, params: { id: expense.id }
      expect(assigns(:expense)).to eq(expense)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the expense' do
        patch :update, params: { id: expense.id, expense: { name: 'Updated Expense' } }
        expense.reload
        expect(expense.name).to eq('Updated Expense')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the expense' do
        patch :update, params: { id: expense.id, expense: { name: nil } }
        expense.reload
        expect(expense.name).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the expense' do
      expense
      expect do
        delete :destroy, params: { id: expense.id }
      end.to change(Expense, :count).by(-1)
    end
  end
end
