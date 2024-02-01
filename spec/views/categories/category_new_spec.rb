# spec/features/category_new_spec.rb
require 'rails_helper'

RSpec.feature 'Category New', type: :feature do
  let(:user) do
    User.create!(name: 'John Doe', email: 'sample@gmail.com', password: 'password', confirmed_at: Time.zone.now)
  end

  before do
    login_as(user, scope: :user)
    visit new_category_path
  end

  scenario 'visits new category page' do
    # Check for the presence of certain elements
    expect(page).to have_css('.form-category-container')
    expect(page).to have_css('.form-category-content')
    expect(page).to have_css('.category-field')

    # Check for the presence of certain content
    expect(page).to have_content('Category Form')
    expect(page).to have_content('Name')
    expect(page).to have_content('Icon')
    expect(page).to have_button('Submit Food')

    # Check for the presence of form
    expect(page).to have_selector('form.category-form')
  end
end
