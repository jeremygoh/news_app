class CommentsController < ApplicationController

  def create
    @article = Article.find(params[:article_id])

    @comment = Comment.new(params[:comment].permit(:name, :body))
    @comment.article = @article

    if @comment.save
      flash[:message] = "Comment created successfully"
    else
      flash[:message] = "Comment not created"
    end
    redirect_to "/articles/#{params[:article_id]}"
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(params[:comment].permit(:name, :body))
    redirect_to "/articles/#{params[:article_id]}/comments/#{params[:id]}"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to "/articles/#{params[:article_id]}"
  end

  def index
    @
  end


end
