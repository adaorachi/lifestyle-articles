class HomePageController < ApplicationController
  def home
    @articles = Article.all_published_articles
    @article_limit_two = @articles.take(2)
    @featured_article_h = Article.most_popular_articles
    @featured_article = Article.featured_article
    @category_first_article = Article.category_all_article
    @categories = Category.all_categories
    @most_popular_articles = Article.most_popular_articles
  end
end
