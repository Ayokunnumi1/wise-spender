# spec/models/income_spec.rb
require 'rails_helper'

RSpec.describe Income, type: :model do
  let(:user) do 
    user = User.new(name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    user.skip_confirmation_notification!
    user.save
    user
  end

  context 'validations' do
    it 'validates presence and numericality of amount' do
      income = Income.new(amount: nil, user_id: user.id)
      expect(income.valid?).to be_falsey
      expect(income.errors[:amount]).to include("can't be blank", "is not a number")

      income.amount = -1
      expect(income.valid?).to be_falsey
      expect(income.errors[:amount]).to include("must be greater than or equal to 0")

      income.amount = 1.5
      expect(income.valid?).to be_falsey
      expect(income.errors[:amount]).to include("must be an integer")

      income.amount = 1000
      expect(income.valid?).to be_truthy
    end
  end

  context 'associations' do
    let(:income) { Income.create(amount: 1000, user_id: user.id) }

    it 'belongs to user' do
      expect(income.user).to eq(user)
    end
  end
end