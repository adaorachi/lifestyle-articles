# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:      "John Doe",
             username:  "johndoe",
             email:     "johndoe@gmail.com",
             password:  "admin123",
             admin:     true)

categories = ['design', 'style', 'travel', 'food']

4.times do |n|
  u_name = Faker::Name.unique.name
  username = Faker::Internet.user_name
  email = "example-#{n+1}@railstutorial.org"
  password = 'password'

  user = User.create!(name: u_name,
              username: username,
              email: email,
              password: password)

  c_name = categories[n]
  priority = 0

  cat = Category.create!(name: c_name,
                  priority: 0)
end

4.times do |m|
  4.times do |n|
    sen_count = 25 * (n+1)

    title = Faker::Book.title[3..50].capitalize
    text = Faker::Lorem.paragraph(sentence_count: sen_count)
    featured_image = Faker::LoremFlickr.image(size: "1500x1200", search_terms: [categories[m]])
    category_id = m+1
    status = "published"
    author_id = n+1
    tag_list = "#{Faker::Book.genre}, #{categories[m]}"
    views = n

    article = Article.create!(title: title,
                              text: text,
                              remote_featured_image_url: featured_image,
                              author_id: author_id,
                              category_id: category_id,
                              status: status,
                              tag_list: tag_list,
                              views: views)

  end

    title = Faker::Book.title[3..50].capitalize
    text = Faker::Lorem.paragraph(sentence_count: 60)
    featured_image = Faker::LoremFlickr.image(size: "1500x1200", search_terms: [categories[m]])
    category_id = m+1
    status = "saved"
    author_id = m+1
    tag_list = "#{Faker::Book.genre}, #{categories[m]}"
    views = 0

    article = Article.create!(title: title,
                              text: text,
                              remote_featured_image_url: featured_image,
                              author_id: author_id,
                              category_id: category_id,
                              status: status,
                              tag_list: tag_list,
                              views: views)


end


4.times do
  4.times do |n|
    v_user_id = n+1
    v_article_id = (1..10).to_a.sample
  
    Vote.create!(user_id: v_user_id,
                 article_id: v_article_id)
    
    article_category = Article.find_by(id: v_article_id)
    article_category.category.increment!(:priority)
    
    b_user_id = n+1
    b_article_id = (1..16).to_a.sample
  
    Bookmark.create!(user_id: b_user_id,
                     article_id: b_article_id)
    
    com_name = Faker::Name.unique.name
    body = Faker::Lorem.paragraph(sentence_count: 8)
    com_article_id = (1..16).to_a.sample

  
    Comment.create!(name: com_name,
                    body: body,
                    article_id: com_article_id)
  end
end




