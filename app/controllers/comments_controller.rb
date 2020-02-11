class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new
    article = Article.find(params[:article_id])
    @comment = article.comments.build(comment_params)
    if @comment.save
      flash[:notice] = 'You commented on this article!'
      redirect_to(request.referer)
    else
      render '/posts'
    end
  end

  private

  def comment_params
    params.required(:comment).permit(:name, :body, :tag, :article_id)
  end
end
