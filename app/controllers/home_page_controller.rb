class HomePageController < ApplicationController
  def home
    @categories = Category.all
  end
end
