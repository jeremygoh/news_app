class ArticlesController < ApplicationController

    def index
      @articles = Article.all
    end

    def new

    end

    def create
      @article = Article.new(params[:article].permit(:title, :body))

      if @article.save
        redirect_to "/articles"
      else
        redirect_to "/articles/new"
      end
    end


    def show
      @article = Article.find(params[:id])
    end

    def edit
    end

    def update
      @article = Article.find(params[:id])
      @article.update(params[:article].permit(:title, :body))
      redirect_to action: "index"
    end

    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to action: "index"
    end

end
