# spec/models/category_spec.rb
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) do
    user = User.new(name: 'Test User', email: 'test@example.com', password: 'password',
                    password_confirmation: 'password')
    user.skip_confirmation_notification! # Add this line to skip sending confirmation email
    user.save
    user
  end

  context 'validations' do
    it 'validates presence of name' do
      category = Category.new(name: nil, icon: 'test_icon', user:)
      expect(category.valid?).to be_falsey
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'validates presence of icon' do
      category = Category.new(name: 'Test Category', icon: nil, user:)
      expect(category.valid?).to be_falsey
      expect(category.errors[:icon]).to include("can't be blank")
    end
  end

  context 'associations' do
    let(:category) { Category.create(name: 'Test Category', icon: 'test_icon', user:) }
    let(:expense) { Expense.create(name: 'Test Expense', amount: 1000, author_id: user.id, category_id: category.id) }

    it 'belongs to user' do
      expect(category.user).to eq(user)
    end

    it 'has many expenses' do
      category.expenses << expense
      expect(category.expenses).to include(expense)
    end
  end
end
