class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'

  belongs_to :category

  has_many :comments, foreign_key: 'article_id', dependent: :destroy

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :votes, foreign_key: 'article_id', dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :bookmarks, foreign_key: 'article_id', dependent: :destroy
  has_many :bookmarked_readers, through: :bookmarks, source: :user

  mount_uploader :featured_image, FeaturedImageUploader

  validates :title, presence: true, length: { in: 3..50 }
  validates :text, presence: true, length: { minimum: 50 }
  validates :featured_image, presence: true
  validates :author_id, presence: true
  validates :category_id, presence: true

  scope :all_published_articles, -> { where('status = ? ', 'published') }
  scope :user_saved_articles, ->(user_id) { where('id = ? and status = ? ', user_id, 'saved') }
  scope :category_first_article, ->(category_id) { where('category_id = ? and status = ?', category_id, 'published').first }
  scope :category_all_article, ->(category_id) { where('category_id = ? and status = ?', category_id, 'published') }
  scope :featured, -> { Vote.group(:article_id).count.sort_by{|k,v| v}.last.first }
  scope :featured_article, -> { find_by(id: featured, status: 'published') }
  scope :most_popular, ->  { Vote.group(:article_id).count.keys.take(5) }
  scope :most_popular_articles, -> { where(id: most_popular) }
  scope :user_pub_articles, ->(user) { where('author_id = ? and status = ?', user, 'published') }
  scope :user_save_articles, ->(user) { where('author_id = ? and status = ?', user, 'saved') }
  scope :user_bookmarks, ->(user) { Bookmark.where('user_id = ? ', user) }
  scope :suggested_articles, ->(category_id) { where('category_id = ? and status = ? ', category_id, 'published') }

  default_scope -> { order(created_at: :desc) }

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(',')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end

  def all_suggested_article(category_id, article)
    suggested_art_arr = []
    suggested_art_arr.concat(Article.suggested_articles(category_id) - [article])
    article.tags.each do |tag|
      suggested_art_arr << tag.articles
    end
    suggested_art_arr.flatten.uniq - [article]
  end

  def self.search_article(search)
    split_search = search.downcase.split(" ")
    arr = []
    self.all_published_articles.each do |article|
      split_search.map { |word| arr << article if article.title.downcase.split(' ').include?(word) }
    end
    arr.uniq
  end

end
