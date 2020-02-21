# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
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
  let!(:article) do
    Article.create!(title: "This is my first article",
                    text: "This is the content of my first article. You should definitely check it out. You will like its content. Haha!",
                    featured_image: File.open(File.join(Rails.root, "app/assets/images/sleezy-photos/travel-1.jpg")),
                    author_id: user.id,
                    category_id: category.id,
                    status: "published",
                    tag_list: "travel, lifestyle",
                    views: 0)

  end

  describe 'Category Page' do
    before do
      visit root_path
    end
    
    scenario 'visit Category Page', type: :feature do
      have_link 'Travel', href: '/categories?name=travel'
      have_link 'Logout', href: logout_path
      expect(page).to have_content('Travel')
      page.first(".cat-name").click
      expect(page.current_path).to eq '/'
    end

    scenario 'show category page', type: :feature do
      expect(current_path).to eq "/"
      have_link 'Home', href: root_path
      have_link 'Write An Article', href: new_article_path
      have_link 'Logout', href: logout_path
    end
  end
end
