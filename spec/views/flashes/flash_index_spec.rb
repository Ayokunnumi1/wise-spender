# spec/features/index_spec.rb
require 'rails_helper'

RSpec.feature "Index", type: :feature do
  before do
    visit root_path
  end

  scenario "visits index page" do
    # Check for the presence of certain elements
    expect(page).to have_css('.flashes_container')
    expect(page).to have_css('.splashlogo_cont')
    expect(page).to have_css('.flashes_btn_container')

    # Check for the presence of image
    expect(page).to have_selector("img[alt='splash logo']")

    # Check for the presence of links
    expect(page).to have_link('Sign up', href: new_user_registration_path)
    expect(page).to have_link('Login', href: new_user_session_path)
  end
end