class HomePageController < ApplicationController
  def home
    @articles = Article.all_published_articles
    @article_limit_two = @articles.take(2)
    @featured_article_h = Article.featured_article
    @featured_article = Article.featured_article.first
    @category_first_article = Article.category_all_article
    @categories = Category.all
    @most_popular_articles = Article.most_popular_articles
  end
end
