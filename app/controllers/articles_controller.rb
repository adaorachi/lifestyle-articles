class ArticlesController < ApplicationController
  before_action :logged_in_user_for_bookmark, only: [:bookmarks]
  before_action :logged_in_user, except: [:show, :bookmarks, :search]

  def new
    @article = Article.new
  end

  def show
    @article = Article.find(params[:id])
    @articles = Article.all
    @comment = Comment.new
    @categories = Category.all

    @pageview = Article.where(author_id: current_user, id: params[:id]).first_or_create
    @pageview.increment!(:views)
  end

  def create
    @article = current_user.articles.build(article_params)
    if params[:save_button]
      @article.status = 'saved'
      if @article.save
        flash['alert-success'] = 'Article saved successfully!'
        render :edit
      else
        render :new 
      end
    elsif params[:publish_button]
      @article.status = 'published'
      if @article.save
        flash['alert-success'] = 'Article published successfully!'
        redirect_to article_path(@article)
      else
        render :new
      end
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if params[:save_button]
      @article.status = 'saved'
      if @article.update(article_params)
        redirect_to(request.referer)
        flash['alert-success'] = 'Article saved successfully!'
      else
        render :edit
      end
    elsif params[:publish_button]
      @article.status = 'published'
      if @article.update(article_params)
        flash['alert-success'] = 'Article published successfully!'
        redirect_to article_path(@article)
      else
        render :edit
      end
    end
  end

  def published_articles
  end

  def saved_articles
  end

  def bookmarks
  end

  def search
    @search_articles = Article.search_article(params[:q])
  end

  private

  def article_params
    params.required(:article).permit(:title, :text, :tag, :featured_image, :tag_list, :category_id, :author_id, :status)
  end

  def increment
    @pageview = Article.where(author_id: current_user, id: params[:id]).first_or_create
    @pageview.increment!(:views)
  end

  def logged_in_user_for_bookmark
    unless logged_in?
      flash['alert-danger'] = 'You must be logged in to bookmark an article!'
      redirect_to(request.referer)
    end
  end
end
