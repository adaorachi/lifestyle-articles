# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Create Events', type: :feature do
  let!(:user) do
    User.create(name: 'John Doe',
                username: 'johndoe',
                email: 'johndoe@example.com',
                password: 'johndoe')
  end
  let!(:category) do
    Category.create!(name: "travel",
                      priority: 0)
  end

  

  scenario 'Create Article', type: :feature do
    visit new_article_path
    page.fill_in :title, with: 'This is my first article'
    page.fill_in 'Text', with: "This is the content of my first article. You should definitely check it out."
    page.fill_in 'Featured_image', with: "travel-1.jpg"
   
    page.fill_in 'Tag_list', with: "travel, lifestyle"
    click_button 'Publish'

    expect(current_path).to eq article_path(1)
    expect(page).to have_text 'Your Article has ben published successfully!'
  end

 end
