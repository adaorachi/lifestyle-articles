class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  
  def index
    cat = params[:name]
    @category = Category.find_by(name: cat)
    @categories = Category.all
    @articles_per_category = Article.articles_per_category(@category.id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash['alert-success'] = 'Category created'
      redirect_to root_path
    else
      render :new
    end
  end


  private

  def category_params
    params.require(:category).permit(:name)
  end

end
