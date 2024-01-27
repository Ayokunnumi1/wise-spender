# spec/features/category_show_spec.rb
require 'rails_helper'

RSpec.feature "Category Show", type: :feature do
  let(:user) do
    User.create!(name: 'John Doe', email: 'sample@gmail.com', password: 'password', confirmed_at: Time.zone.now)
  end

  let(:category) { Category.create!(name: 'Food', icon: "🍔", user: user) }
  let!(:expense) { Expense.create!(name: 'Burger', amount: 10, category: category, author: user) } # associate the author with the expense

  before do
    login_as(user, scope: :user)
    visit category_path(category)
  end

  scenario "visits category show page" do
    # Check for the presence of certain elements
    expect(page).to have_css('.expense-section')
    expect(page).to have_css('.expense-navbar')
    expect(page).to have_css('.categories-container')
    expect(page).to have_css('.category-item')

    # Check for the presence of certain content
    expect(page).to have_content('Most Recent')
    expect(page).to have_content('Total Amount: $10') # Assuming the total amount is 10
    expect(page).to have_content('Burger') # Assuming the expense name is 'Burger'
    expect(page).to have_content('$10') # Assuming the expense amount is 10

    # Check for the presence of buttons
    expect(page).to have_button('Edit')
    expect(page).to have_button('Delete')
    expect(page).to have_link('Add New Expenses')
  end
end