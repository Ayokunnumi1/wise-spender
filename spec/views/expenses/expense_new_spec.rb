# spec/features/expense_new_spec.rb
require 'rails_helper'

RSpec.feature 'Expense New', type: :feature do
  let(:user) do
    User.create!(name: 'John Doe', email: 'sample@gmail.com', password: 'password', confirmed_at: Time.zone.now)
  end

  let(:category) { Category.create!(name: 'Food', icon: '🍔', user:) }

  before do
    login_as(user, scope: :user)
    visit new_expense_path(category_id: category.id)
  end

  scenario 'visits new expense page' do
    # Check for the presence of certain elements
    expect(page).to have_css('.form-expense-container')
    expect(page).to have_css('.form-expense-content')
    expect(page).to have_css('.expense-form')

    # Check for the presence of form fields
    expect(page).to have_field('Category')
    expect(page).to have_field('Amount')

    # Check for the presence of submit button
    expect(page).to have_button('Save Expense')
  end
end
