# spec/models/expense_spec.rb
require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) do 
    user = User.new(name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    user.skip_confirmation_notification!
    user.save
    user
  end
  let(:category) { Category.create(name: 'Test Category', icon: 'test_icon', user: user) }

  context 'validations' do
    it 'validates presence and numericality of amount' do
      expense = Expense.new(name: 'Test Expense', amount: nil, author_id: user.id, category_id: category.id)
      expect(expense.valid?).to be_falsey
      expect(expense.errors[:amount]).to include("can't be blank", "is not a number")

      expense.amount = -1
      expect(expense.valid?).to be_falsey
      expect(expense.errors[:amount]).to include("must be greater than or equal to 0")

      expense.amount = 1.5
      expect(expense.valid?).to be_falsey
      expect(expense.errors[:amount]).to include("must be an integer")

      expense.amount = 1000
      expect(expense.valid?).to be_truthy
    end

    it 'validates presence of name' do
      expense = Expense.new(name: nil, amount: 1000, author_id: user.id, category_id: category.id)
      expect(expense.valid?).to be_falsey
      expect(expense.errors[:name]).to include("can't be blank")
    end
  end

  context 'associations' do
    let(:expense) { Expense.create(name: 'Test Expense', amount: 1000, author_id: user.id, category_id: category.id) }

    it 'belongs to author' do
      expect(expense.author).to eq(user)
    end

    it 'belongs to category' do
      expect(expense.category).to eq(category)
    end
  end
end