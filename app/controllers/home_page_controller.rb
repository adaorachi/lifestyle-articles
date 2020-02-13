class HomePageController < ApplicationController
  def home
    
    @articles = Article.all
    @categories = Category.all
  end
end
