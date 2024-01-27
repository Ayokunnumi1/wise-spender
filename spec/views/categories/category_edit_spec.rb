# spec/features/category_edit_spec.rb
require 'rails_helper'

RSpec.feature 'Category Edit', type: :feature do
  let(:user) do
    User.create!(name: 'John Doe', email: 'sample@gmail.com', password: 'password', confirmed_at: Time.zone.now)
  end

  let(:category) { Category.create!(name: 'Food', icon: '🍔', user:) }

  before do
    login_as(user, scope: :user)
    visit edit_category_path(category)
  end

  scenario 'visits edit category page' do
    # Check for the presence of certain elements
    expect(page).to have_css('.form-category-container')
    expect(page).to have_css('.form-category-content')
    expect(page).to have_css('.category-field')

    # Check for the presence of certain content
    expect(page).to have_content('Edit Category')
    expect(page).to have_content('New Category Name')
    expect(page).to have_content('New Category Icon')
    expect(page).to have_button('Save Category')

    # Check for the presence of form
    expect(page).to have_selector('form.category-form')
  end
end
