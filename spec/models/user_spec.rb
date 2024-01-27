# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'validates presence of name' do
      user = User.new(name: nil)
      expect(user.valid?).to be_falsey
      expect(user.errors[:name]).to include("can't be blank")
    end
  end

  context 'associations' do
    let(:user) do
      User.new(name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    end
    let(:category) { Category.create(name: 'Test Category', user:) }
    let(:expense) { Expense.create(name: 'Test Expense', category:) }
    let(:income) { Income.create(amount: 1000, user:) } # Changed 'name' to 'amount'

    before do
      # Disable sending confirmation email
      user.skip_confirmation_notification!
      user.save
    end

    it 'has many categories' do
      user.categories << category
      expect(user.categories).to include(category)
    end

    it 'has many expenses through categories' do
      user.categories << category
      category.expenses << expense
      expect(user.expenses).to include(expense)
    end

    it 'has many incomes' do
      user.incomes << income
      expect(user.incomes).to include(income)
    end
  end
end
